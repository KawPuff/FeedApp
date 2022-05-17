//
//  NSLayoutAnchors.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 06.01.2022.
//

import UIKit

enum LayoutAnchor {
    case relative(attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, relatedTo: NSLayoutConstraint.Attribute, multiplier: CGFloat, constant: CGFloat)
    
    case constant(attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, constant: CGFloat)
}

extension LayoutAnchor {
    
    static func relative(attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, relatedTo: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1) -> (CGFloat) -> LayoutAnchor {
        return { constant in
            return relative(attribute: attribute, relation: relation, relatedTo: relatedTo, multiplier: multiplier, constant: constant)
        }
    }
    
    
    static func constant(attribute: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation) -> (CGFloat) -> LayoutAnchor {
        return { constant in
            return .constant(attribute: attribute, relation: relation, constant: constant)
            
        }
    }
    
    static let leading = relative(attribute: .leading, relation: .equal, relatedTo: .leading)
    static let trailing = relative(attribute: .trailing, relation: .equal, relatedTo: .trailing)
    static let top = relative(attribute: .top, relation: .equal, relatedTo: .top)
    static let bottom = relative(attribute: .bottom, relation: .equal, relatedTo: .bottom)
    
    static let centerX = relative(attribute: .centerX, relation: .equal, relatedTo: .centerX)
    static let centerY = relative(attribute: .centerY, relation: .equal, relatedTo: .centerY)
    
    static let width = constant(attribute: .width, relation: .equal)
    static let height = constant(attribute: .height, relation: .equal)
    
}

