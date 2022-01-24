//
//  PostData.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 20.01.2022.
//

import Foundation

struct Link: ListingItem {
    
    init(id: String) {
        self.id = id
        self.name = ""
        self.subreddit = ""
    }
    
    let id: String
    
    let name: String
    
    static public let kind: String = "t3"
    
    var subreddit: String
    
}
