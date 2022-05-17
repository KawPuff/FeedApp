//
//  LinkOpenerDelegate.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 05.04.2022.
//

import Foundation

protocol LinkOpenerDelegate: AnyObject {
    func openLink(url: URL)
}
