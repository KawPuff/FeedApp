//
//  ListingModel.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 20.01.2022.
//

import Foundation

struct Listing {
    
    var after: String
    var before: String
    
    var dist: Int
    
    var children: [ListingItem]
    
    init() {
        self.after = ""
        self.before = ""
        self.dist = 0
        
        self.children = [ListingItem]()
    }
    init(json: JSONDictionary) {
        self.after = json["after"] as? String ?? ""
        self.before = json["before"] as? String ?? ""
        
        self.dist = json["dist"] as? Int ?? 0
        
        self.children = [ListingItem]()
        
        let listingItems = json["children"] as? [[String:Any]] ?? []
        for listingItem in listingItems {
            switch listingItem["kind"] as! String{
            case "t3":
                children.append(Post(json: listingItem["data"] as? JSONDictionary ?? [:]))
                break
            default:
                print("unknown")
                break
            }
        }
    }
}
