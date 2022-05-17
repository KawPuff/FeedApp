//
//  ListingItemProtocol.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 20.01.2022.
//

import Foundation

protocol ListingItem {
    var id: String {get}
    var name: String {get}
    static var kind: String {get}
    
}
