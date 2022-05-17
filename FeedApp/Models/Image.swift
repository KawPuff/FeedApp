//
//  Image.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 12.04.2022.
//

import Foundation

struct Image{
    
    let url: String
    
    let width: Float
    let height: Float
    
    init(json: JSONDictionary) {
        url = json["url"] as? String ?? ""
        width = json["width"] as? Float ?? 0
        height = json["height"] as? Float ?? 0
    }
    init(jsonMeta: JSONDictionary){
        url = jsonMeta["u"] as? String ?? ""
        width = jsonMeta["x"] as? Float ?? 0
        height = jsonMeta["y"] as? Float ?? 0
    }
}
