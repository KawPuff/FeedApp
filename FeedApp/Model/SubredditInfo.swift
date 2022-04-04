//
//  SubredditInfo.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 29.03.2022.
//

import Foundation

struct SubredditInfo: ListingItem {
    var id: String
    
    var name: String
    
    static var kind: String = "t5"
    
    let avatarUrl: String
    
    init() {
        id  = ""
        name = ""
        avatarUrl = ""
    }
    init(from jsonDictionary: JSONDictionary) {
        id = jsonDictionary["id"] as? String ?? ""
        name = jsonDictionary["name"]  as? String ?? ""
        avatarUrl = jsonDictionary["icon_img"] as? String ?? ""
    }
}
