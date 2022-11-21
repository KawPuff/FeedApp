//
//  LinkParser.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 27.04.2022.
//

import Foundation
import ImageIO

enum ParseError: Error {
    case fetchUrl
}
fileprivate typealias Size = (width: Int, height: Int)

class PostParser {
    func parse(_ post: Post) throws -> FeedDataView  {
        guard let url = URL(string: post.url) else {
            throw ParseError.fetchUrl
        }
        if url.isImageURL {
            return SingleImageDataView(post: post, imageSize: fetchImageSizeFrom(url: url))
        }
        
        if post.isVideo {
            return MediaDataView(post: post)
        }
        if !post.selftext.isEmpty{
            return TextDataView(post: post)
        }
        if !post.galleryItemsData.isEmpty{
            return AlbumDataView(post: post)
        }
        if isRedditDomain(post.domain) {
            return TitleDataView(post: post)
        }
        return LinkDataView(post: post)
    }
    private func isRedditDomain(_ domain: String) -> Bool {
        let domains = ["reddit.com","i.reddituploads.com", "i.reddit.com", "g.redditmedia.com", "i.redditmedia.com", "i.redd.it", "v.redd.it"]
        return domains.contains(domain)
    }
   
    private func fetchImageSizeFrom(url: URL) -> Size {
        if let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil) {
            if let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? Dictionary<CFString, Any> {
                let width = properties[kCGImagePropertyPixelWidth] as! Int
                let height = properties[kCGImagePropertyPixelWidth] as! Int
                return (width,height)
            }
        }
        return (0,0)
    }
}
