//
//  UIViewExtension.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 06.01.2022.
//

import UIKit

extension UIView {
    func addSubview(_ view: UIView,layoutAnchors: [LayoutAnchor]){
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.activate(layoutAnchors: layoutAnchors, to: self)
    }
    
    func activate(layoutAnchors: [LayoutAnchor], to item: UIView? = nil){
        let constraints = layoutAnchors.map { anchor in
            NSLayoutConstraint(from: self, to: item, anchor: anchor)
        }
        NSLayoutConstraint.activate(constraints)
    }
}
