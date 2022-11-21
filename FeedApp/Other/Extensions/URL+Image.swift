//
//  URLExtension.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 03.05.2022.
//

import Foundation

extension URL {
    var isImageURL: Bool {
        get {
            let imageExtensions = ["png", "img", "jpg", "gif"]
            return imageExtensions.contains(self.pathExtension)
        }
    }
}
