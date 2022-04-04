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
    let subreddit: String
    let selftext: String
    let title: String
    let author: String
//    let downs: String
//    let ups: String
    let score: Int64
    let url: String
    let isVideo: Bool
    let media: Media
    var kind: PostType = .titleOnly
    static public let kind: String = "t3"
    
    init(id: String) {
        self.id = id
        self.name = ""
        self.subreddit = ""
        self.selftext = ""
        self.title = ""
        self.author = ""
        self.score = 0
        self.url = ""
        self.isVideo = false
        self.media = Media(jsonDictionary: [:])
    }
    
    init(json: JSONDictionary) {
        self.id = json["id"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        self.subreddit = json["subreddit_name_prefixed"] as? String ?? ""
        self.selftext = json["selftext"] as? String ?? ""
        if !self.selftext.isEmpty { self.kind = .text}
        self.title = json["title"] as? String ?? ""
        self.author = json["author"] as? String ?? ""
        self.score = json["score"] as? Int64 ?? 0
        self.url = json["url"] as? String ?? ""
        self.isVideo = json["is_video"] as? Bool ?? false
        if self.isVideo {self.kind = .video}
        
        self.media = Media(jsonDictionary: json["media"] as? JSONDictionary ?? [:])
        
    }
}
