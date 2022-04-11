//
//  FeedPresenter.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 02.03.2022.
//

import Foundation
import UIKit
protocol FeedPresenter {
    
    func getPostCount() -> Int
    
    func getPostType(_ index: Int) -> PostType
    
    func getSubredditImage(_ index: Int, completion: @escaping (UIImage?) -> Void)
    func getPostTitle(_ index: Int) -> String
    func getSubredditName(_ index: Int) -> String
    func getUsername(_ index: Int) -> String
    func getImageSizeAt(index: Int) -> CGSize
    func loadNextPosts(completion: @escaping () -> ())
}
protocol FeedView: AnyObject {
    var presenter: FeedPresenter! { get set }
}
final class FeedPresenterImpl: FeedPresenter {
    
    var view: FeedView
    var listing: Listing
    var networking: NetworkManager🌐 = RedditManager.shared
    
    public init(view: FeedView){
        self.view = view
        self.listing = Listing()
        
        self.view.presenter = self
        
        
    }
    func getPostType(_ index: Int) -> PostType {
//        guard let post = listing.children[index] as? Link else {
//            return .titleOnly
//        }
//        
        return .photo
    }
    
    func getSubredditImage(_ index: Int, completion: @escaping (UIImage?) -> Void){
        guard let post = listing.children[index] as? Link else{
            return
        }
        // Getting Subreddit Info to get avatar url
        networking.getSubredditInfo(subreddit: post.subreddit) { [unowned self] result in
            networking.downloadImage(urlString: result) { image in
                completion(image)
            }
        }
    }
    
    func getPostTitle(_ index: Int) -> String {
        guard let post = listing.children[index] as? Link else {
            return ""
        }
        return post.title
    }
    
    func getSubredditName(_ index: Int) -> String {
        guard let post = listing.children[index] as? Link else {
            return ""
        }
        return post.subreddit
    }
    
    func getUsername(_ index: Int) -> String {
        guard let post = listing.children[index] as? Link else {
            return ""
        }
        return "u/" + post.author
    }
    func getPostCount() -> Int {
        return listing.children.count
    }
    func getPostImages() -> [UIImage] {
        return []
    }
    func getImageSizeAt(index: Int) -> CGSize{
        let image = UIImage(named: "blond")!
        return CGSize(width: image.size.width, height: image.size.height)
    }
    func loadNextPosts(completion: @escaping () -> ()) {
        networking.getPosts(subreddit: "popular", limit: 25, after: listing.children.last?.name){ result in
            switch result {
            case .success(let listing):
                self.listing.children += listing.children
                completion()
                break
            case .failure(let errorString):
                completion()
                break
            }
        }
    }
    
    
}
