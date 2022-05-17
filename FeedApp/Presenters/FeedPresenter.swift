//
//  FeedPresenter.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 02.03.2022.
//

import UIKit


protocol FeedPresenter {
    func fetchNextPosts(completion: @escaping (Response<[FeedDataView]>) -> ())
}


final class FeedPresenterImpl: FeedPresenter {
    
    private var view: FeedView
    private var listing: Listing
    private var networking: NetworkService🌐 = RedditAPI.shared
    
    public init(view: FeedView){
        self.view = view
        self.listing = Listing()
        self.view.attachPresenter(self)
    }

    func fetchNextPosts(completion: @escaping (Response<[FeedDataView]>) -> ()) {
        networking.fetchListing(subreddit: "popular", postsLimit: 25, after: listing.children.last?.name){ [unowned self] response in
            if let error = response.error {
                completion((nil,error))
                return
            }
            if let listing = response.data {
                self.listing.children += listing.children
                completion((prepareDataViews(listing),nil))
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
