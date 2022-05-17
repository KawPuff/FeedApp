//
//  PreviewImage.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 12.04.2022.
//

import Foundation
import ImageIO

class PreviewImage{
    
    let source: Image
    
    let resolutions: [Image]
    
    init(json: JSONDictionary) {
        
        self.source = Image(json: json["source"] as? JSONDictionary ?? [:])
        
        let resArr = json["resolutions"] as? [JSONDictionary] ?? []
        
        self.resolutions = resArr.map({
            Image(json: $0)
        })
    }
}
