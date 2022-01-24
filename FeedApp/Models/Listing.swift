//
//  ListingModel.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 20.01.2022.
//

import Foundation

struct Listing {
    var after: String
    var dist: Int
    var children: [ListingItem]
}
