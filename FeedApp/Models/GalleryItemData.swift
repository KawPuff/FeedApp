//
//  GalleryItemData.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 10.05.2022.
//

import Foundation

struct GalleryItemData {
    let mediaId: String
    let id: UInt
    
    init(json: JSONDictionary) {
        self.mediaId = json["media_id"] as? String ?? ""
        self.id = json["id"] as? UInt ?? 0
    }
}
