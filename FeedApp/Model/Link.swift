//
//  PostData.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 20.01.2022.
//

import Foundation

struct Link: ListingItem {
    let id: String
    let name: String
    var subreddit: String
    
    static public let kind: String = "t3"
    
    init(id: String) {
        self.id = id
        self.name = ""
        self.subreddit = ""
    }
    init(json: JSONDictionary) {
        self.id = json["id"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        self.subreddit = json["subreddit"] as? String ?? ""
    }
}
