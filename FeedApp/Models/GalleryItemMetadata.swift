//
//  GalleryItemMetadata.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 10.05.2022.
//

import Foundation

struct GalleryItemMetadata {
    
    let status: String
    
    let previews: [Image]
    
    init(json: JSONDictionary) {
        self.status = json["status"] as? String ?? ""
        let previews = json["p"] as? [JSONDictionary] ?? []
        self.previews = previews.map({
            Image(jsonMeta: $0)
        })
        
    }
}
