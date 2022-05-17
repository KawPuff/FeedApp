//
//  String+HTMLExtension.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 10.05.2022.
//

import Foundation

extension String {
    var decodedHTML: String? {
        get {
            guard let data = self.data(using: .utf8) else {
                return nil
            }
            let opts: [NSAttributedString.DocumentReadingOptionKey : Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            guard let attrString = try? NSAttributedString(data: data, options: opts, documentAttributes: nil) else{
                return nil
            }
            return attrString.string
        }
    }
}
