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
    
    func getSubredditImage(_ index: Int) -> UIImage
    func getPostTitle(_ index: Int) -> String
    func getSubredditName(_ index: Int) -> String
    func getUsername(_ index: Int) -> String
    
    func loadNextPosts(completion: @escaping () -> ())
}
protocol FeedView: AnyObject {
    var delegate: FeedPresenter! { get set }
}
class FeedPresenterImpl: FeedPresenter {
    
    var view: FeedView
    var listing: Listing
    var networking: NetworkManager = RedditManager.shared
    
    public init(view: FeedView){
        self.view = view
        self.listing = Listing()
        
        self.view.delegate = self
        
        
    }
    func getPostType(_ index: Int) -> PostType {
        guard let post = listing.children[index] as? Link else {
            return .titleOnly
        }
        
        return post.kind
    }
    
    func getSubredditImage(_ index: Int) -> UIImage {
        return UIImage()
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
        return ""
    }
    func getPostCount() -> Int {
        return listing.children.count
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
                print(errorString)
                break
            }
        }
    }
    
    
}
