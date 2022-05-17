//
//  PostData.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 20.01.2022.
//

import Foundation

struct Post: ListingItem {
    
    let id: String
    
    let name: String
    
    let subreddit: String
    
    let thumbnail: String
    
    let selftext: String
    
    let title: String
    
    let author: String
    
    let downs: UInt64
    
    let ups: UInt64
    
    let commentsCount: UInt64
    
    let score: Int64
    
    let domain: String
    
    let url: String
    
    let isVideo: Bool
    
    let media: Media
    
    let previewImages: [PreviewImage]
    
    let galleryItemsData: [GalleryItemData]
    
    let galleryItemsMetadata: [GalleryItemMetadata]
    
    static public let kind: String = "t3"
    
    init(id: String) {
        self.id = id
        self.name = ""
        self.subreddit = ""
        self.thumbnail = ""
        self.selftext = ""
        self.title = ""
        self.author = ""
        self.downs = 0
        self.ups = 0
        self.commentsCount = 0
        self.score = 0
        self.domain = ""
        self.url = ""
        self.isVideo = false
        self.media = Media(jsonDictionary: [:])
        self.previewImages = []
        self.galleryItemsData = []
        self.galleryItemsMetadata = []
    }
    
    init(json: JSONDictionary) {
        self.id = json["id"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        self.subreddit = json["subreddit_name_prefixed"] as? String ?? ""
        self.thumbnail = json["thumbnail"] as? String ?? ""
        self.selftext = json["selftext"] as? String ?? ""
        self.title = json["title"] as? String ?? ""
        self.author = json["author"] as? String ?? ""
        self.downs = json["downs"] as? UInt64 ?? 0
        self.ups = json["ups"] as? UInt64 ?? 0
        self.commentsCount = json["num_comments"] as? UInt64 ?? 0
        self.score = json["score"] as? Int64 ?? 0
        self.domain = json["domain"] as? String ?? ""
        self.url = json["url"] as? String ?? ""
        self.isVideo = json["is_video"] as? Bool ?? false
        self.media = Media(jsonDictionary: json["media"] as? JSONDictionary ?? [:])
        
        let preview = json["preview"] as? JSONDictionary ?? [:]
        let imagesArr = preview["images"] as? [JSONDictionary] ?? []
        
        self.previewImages = imagesArr.map({
            PreviewImage(json: $0)
        })
        
        let galleryData = json["gallery_data"] as? JSONDictionary ?? [:]
        let galleryItemsJson = galleryData["items"] as? [JSONDictionary] ?? []
        self.galleryItemsData = galleryItemsJson.map({
            GalleryItemData(json: $0)
        })
        
        let galleryMetadata = json["media_metadata"] as? JSONDictionary ?? [:]
        self.galleryItemsMetadata = self.galleryItemsData.map({
            GalleryItemMetadata(json: galleryMetadata[$0.mediaId] as? JSONDictionary ?? [:])
        })
    }
}
