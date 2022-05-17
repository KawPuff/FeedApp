//
//  NSLayoutConstraintExtension.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 06.01.2022.
//

import UIKit

extension NSLayoutConstraint {
    convenience init(from: UIView, to: UIView?, anchor: LayoutAnchor) {
        switch anchor {
        case let .relative(attribute, relation, relatedTo, multiplier, constant):
            self.init(item: from, attribute: attribute, relatedBy: relation, toItem: to, attribute: relatedTo, multiplier: multiplier, constant: constant)
            break
        
        case let .constant(attribute, relation, constant):
            self.init(item: from, attribute: attribute, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: constant)
            break
        }
    }
}
