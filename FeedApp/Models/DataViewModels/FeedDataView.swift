//
//  FeedDataView.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 11.04.2022.
//

import Foundation
/* Структура, содержащая подготовленные для отображения данные */
protocol FeedDataView {
    
    var type: PostType{ get }
    
    var subreddit: String { get }
    
    var user: String { get }
    
    var commentsCount: String { get }
    
    var score: String { get }
    
    var title: String { get }
    
}
struct TitleDataView: FeedDataView {
    
    let type: PostType = .titleOnly
    
    let subreddit: String
    
    let user: String
    
    let commentsCount: String
    
    let score: String
    
    let title: String
    
    init(subreddit: String, user: String, commentsCount: UInt64, score: Int64, title: String) {
        self.subreddit = subreddit
        self.user = user
        self.commentsCount = commentsCount.formatted != "0" ? commentsCount.formatted : ""
        self.score = score.formatted != "0" ? score.formatted : "Vote"
        self.title = title
    }
    init(post: Post) {
        self.subreddit = post.subreddit
        self.user = post.author
        self.commentsCount = post.commentsCount.formatted != "0" ? post.commentsCount.formatted : ""
        self.score = post.score.formatted != "0" ? post.score.formatted : "Vote"
        self.title = post.title
    }
}

struct TextDataView: FeedDataView {
    
    let type: PostType = .text
    
    let subreddit: String
    
    let user: String
    
    let commentsCount: String
    
    let score: String
    
    let title: String
    
    let text: String
    
    init(){
        subreddit = "r/Subreddit"
        user = "u/User"
        commentsCount = ""
        score = "Vote"
        title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sit amet consectetur adipiscing elit duis tristique sollicitudin nibh sit. Turpis in eu mi bibendum neque egestas. Purus in massa tempor nec feugiat nisl pretium fusce id. Eget velit aliquet sagittis id consectetur purus ut. Urna cursus eget nunc scelerisque viverra mauris in. Tellus integer feugiat scelerisque varius. Netus et malesuada fames ac turpis. Egestas maecenas pharetra convallis posuere morbi leo urna molestie. Consequat id porta nibh venenatis cras sed felis eget velit. Felis eget nunc lobortis mattis aliquam faucibus purus. Sodales neque sodales ut etiam sit amet nisl purus. Amet nulla facilisi morbi tempus. Diam vulputate ut pharetra sit amet. Quisque id diam vel quam. Etiam tempor orci eu lobortis elementum nibh tellus molestie nunc. Tristique risus nec feugiat in fermentum. Fermentum et sollicitudin ac orci phasellus egestas. Donec ac odio tempor orci dapibus ultrices in iaculis."
    }
    
    init(subreddit: String, user: String, commentsCount: UInt64, score: Int64, title: String, text: String) {
        self.subreddit = subreddit
        self.user = user
        self.commentsCount = commentsCount.formatted != "0" ? commentsCount.formatted : ""
        self.score = score.formatted != "0" ? score.formatted : "Vote"
        self.title = title
        self.text = text
    }
    init(post: Post) {
        self.subreddit = post.subreddit
        self.user = post.author
        self.commentsCount = post.commentsCount.formatted != "0" ? post.commentsCount.formatted : ""
        self.score = post.score.formatted != "0" ? post.score.formatted : "Vote"
        self.title = post.title
        self.text = post.selftext
    }
}
struct LinkDataView: FeedDataView {
    
    
    let type: PostType = .link
    
    let subreddit: String
    
    let user: String
    
    let commentsCount: String
    
    let score: String
    
    let title: String
    
    let url: String
    
    let domainTitle: String
    
    let previewImageUrl: String
    
    let previewImageWidth: Float
    
    let previewImageHeight: Float
    
    init() {
        subreddit = "r/Subreddit"
        user = "u/User"
        commentsCount = ""
        score = "Vote"
        title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        url = "https://www.google.ru/"
        domainTitle = "www.google.ru"
        previewImageUrl = ""
        previewImageWidth = 0
        previewImageHeight = 0
    }
    
    init(subreddit: String, user: String, commentsCount: UInt64, score: Int64, title: String, url: String, domainTitle: String, previewImageUrl: String, previewImageWidth: Float, previewImageHeight: Float) {
        self.subreddit = subreddit
        self.user = user
        self.commentsCount = commentsCount.formatted != "0" ? commentsCount.formatted : ""
        self.score = score.formatted != "0" ? score.formatted : "Vote"
        self.title = title
        self.url = url
        self.domainTitle = domainTitle
        self.previewImageUrl = previewImageUrl
        self.previewImageWidth = previewImageWidth
        self.previewImageHeight = previewImageHeight
    }
    
    init(post: Post) {
        self.subreddit = post.subreddit
        self.user = post.author
        self.commentsCount = post.commentsCount.formatted != "0" ? post.commentsCount.formatted : ""
        self.score = post.score.formatted != "0" ? post.score.formatted : "Vote"
        self.title = post.title
        self.url = post.url
        self.domainTitle = post.domain
        self.previewImageUrl = post.previewImages.first?.source.url.decodedHTML ?? ""
        self.previewImageWidth = post.previewImages.first?.source.width ?? 0
        self.previewImageHeight = post.previewImages.first?.source.height ?? 0
    }
}
struct SingleImageDataView: FeedDataView {
    
    let type: PostType = .image
    
    let subreddit: String
    
    let user: String
    
    let commentsCount: String
    
    let score: String
    
    let title: String
    
    let imageUrl: String
    
    let imageWidth: Int
    
    let imageHeight: Int
    
    init() {
        self.subreddit = ""
        self.user = ""
        self.commentsCount = ""
        self.score = "Vote"
        self.title = ""
        self.imageUrl = ""
        self.imageWidth = 0
        self.imageHeight = 0
    }
    init(subreddit: String, user: String, commentsCount: UInt64, score: Int64, title: String, imageUrl: String, imageWidth: Int, imageHeight: Int) {
        self.subreddit = subreddit
        self.user = user
        self.commentsCount = commentsCount.formatted != "0" ? commentsCount.formatted : ""
        self.score = score.formatted != "0" ? score.formatted : "Vote"
        self.title = title
        self.imageUrl = imageUrl
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
    }
    
    init(post: Post, imageSize: (width:Int,height:Int)) {
        self.subreddit = post.subreddit
        self.user = post.author
        self.commentsCount = post.commentsCount.formatted != "0" ? post.commentsCount.formatted : ""
        self.score = post.score.formatted != "0" ? post.score.formatted : "Vote"
        self.title = post.title
        self.imageUrl = post.url
        self.imageWidth = imageSize.width
        self.imageHeight = imageSize.height
    }
}
struct MediaDataView: FeedDataView {
    
    let type: PostType = .media
    
    let subreddit: String
    
    let user: String
    
    let commentsCount: String
    
    let score: String
    
    let title: String
    
    let url: String
    
    let height: Int
    
    let width: Int
    
    let isGif: Bool
    
    init() {
        subreddit = "r/Subreddit"
        user = "user"
        commentsCount = "15.5k"
        score = "20.3k"
        title = "Check out new video"
        url = ""
        height = 0
        width = 0
        isGif = false
    }
    
    init(post: Post) {
        self.subreddit = post.subreddit
        self.user = post.author
        self.commentsCount = post.commentsCount.formatted != "0" ? post.commentsCount.formatted : ""
        self.score = post.score.formatted != "0" ? post.score.formatted : "Vote"
        self.title = post.title
        self.url = post.media.redditVideo.hlsUrl.decodedHTML!
        self.height = post.media.redditVideo.height
        self.width = post.media.redditVideo.width
        self.isGif = post.media.redditVideo.isGif
    }
}
struct AlbumDataView: FeedDataView {

    struct ImageDataView {
        
        let imageUrl: String
        
        let height: Float
        
        let width: Float
        
    }
    
    let type: PostType = .album
    
    let subreddit: String
    
    let user: String
    
    let commentsCount: String
    
    let score: String
    
    let title: String
    
    var imagesDataView: [ImageDataView] = []
    
    init(){
        self.subreddit = "r/Subreddit"
        self.user = "u/User"
        self.commentsCount = ""
        self.score = "Vote"
        self.title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
    
    init(subreddit: String, user: String, commentsCount: UInt64, score: Int64, title: String) {
        self.subreddit = subreddit
        self.user = user
        self.commentsCount = commentsCount.formatted != "0" ? commentsCount.formatted : ""
        self.score = score.formatted != "0" ? score.formatted : "Vote"
        self.title = title
    }
    
    init(post: Post) {
        self.subreddit = post.subreddit
        self.user = post.author
        self.commentsCount = post.commentsCount.formatted != "0" ? post.commentsCount.formatted : ""
        self.score = post.score.formatted != "0" ? post.score.formatted : "Vote"
        self.title = post.title
        
        post.galleryItemsMetadata.forEach {
            guard let image = $0.previews.last, let decodedUrl = image.url.decodedHTML else {
                return
            }
            imagesDataView.append(ImageDataView(imageUrl: decodedUrl, height: image.height, width: image.width))
        }
    }
}
