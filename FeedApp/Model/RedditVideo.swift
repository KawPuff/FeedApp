//
//  RedditVideo.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 09.03.2022.
//

import Foundation

struct RedditVideo {
    let bitrate: Int
    let fallbackUrl: String
    let height: Int
    let width: Int
    let duration: Float
    let isGif: Bool
    init(jsonDictionary: JSONDictionary) {
        self.bitrate = jsonDictionary["bitrate"] as? Int ?? 0
        self.fallbackUrl = jsonDictionary["fallback_url"] as? String ?? ""
        self.height = jsonDictionary["height"] as? Int ?? 0
        self.width = jsonDictionary["width"] as? Int ?? 0
        self.duration = jsonDictionary["duration"] as? Float ?? 0.0
        self.isGif = jsonDictionary["is_gif"] as? Bool ?? false
    }
}
