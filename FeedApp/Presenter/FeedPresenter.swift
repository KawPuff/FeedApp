//
//  FeedPresenter.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 02.03.2022.
//

import UIKit


protocol FeedPresenter {
    
    func fetchImage(by url: String, _ completion: @escaping (UIImage?) -> ())
    
    func fetchNextPosts(completion: @escaping (Response<[FeedDataView]>) -> ())
    
}


final class FeedPresenterImpl: FeedPresenter {
    
    private var view: FeedView
    private var listing: Listing
    private var networking: NetworkService🌐 = RedditAPI.shared
    private var isFetching: Bool = false
    
    public init(view: FeedView){
        self.view = view
        self.listing = Listing()
        self.view.attachPresenter(self)
    }
    
    func fetchImage(by url: String, _ completion: @escaping (UIImage?) -> ()) {
        ImageLoader.shared.load(by: url, completion: completion)
    }
    
    func fetchNextPosts(completion: @escaping (Response<[FeedDataView]>) -> ()) {
        guard !isFetching else { return }
        isFetching = true
        networking.fetchListing(subreddit: "popular", postsLimit: 25, after: listing.children.last?.name){
            [unowned self] response in
            if let error = response.error {
                completion((nil,error))
                isFetching = false
                return
            }
            if let listing = response.data {
                
                for post in listing.children {
                    self.listing.children.append(post)
                }
                DispatchQueue.global().async {
                    let preparedDataViews = self.prepareDataViews(listing)
                    DispatchQueue.main.async {
                        self.isFetching = false
                        completion((preparedDataViews,nil))
                    }
                    
                }
            }
        }
    }
    private func prepareDataViews(_ listing: Listing) -> [FeedDataView] {
        return listing.children.map {
            return fetchDataViewFromLink($0 as! Post)
        }
    }
    private func fetchDataViewFromLink(_ link: Post) -> FeedDataView {
        //FIXME: Handle force-try
        return try! PostParser().parse(link)
    }

}
