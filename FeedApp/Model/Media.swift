//
//  Media.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 09.03.2022.
//

import Foundation

struct Media {
    let redditVideo: RedditVideo
    init(jsonDictionary: JSONDictionary){
        self.redditVideo = RedditVideo(jsonDictionary: jsonDictionary["reddit_video"] as? JSONDictionary ?? [:])
    }
}
