//
//  SubredditInfo.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 29.03.2022.
//

import Foundation

struct Subreddit: ListingItem {

    var id: String
    
    var name: String
    
    static var kind: String = "t5"
    
    let iconUrl: String
    
    init() {
        id  = ""
        name = ""
        iconUrl = ""
    }
    init(from jsonDictionary: JSONDictionary) {
        id = jsonDictionary["id"] as? String ?? ""
        name = jsonDictionary["name"]  as? String ?? ""
        iconUrl = jsonDictionary["icon_img"] as? String ?? ""
    }
}
