//
//  MediaCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 25.04.2022.
//

import UIKit
import AVKit
import AVFoundation

class MediaCell: UITableViewCell {
    
    var mediaHeight: CGFloat {
        get{
            return heightConstraint.constant
        }
        set {
            heightConstraint.constant = newValue
        }
    }
    private var heightConstraint: NSLayoutConstraint!
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let mediaView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setupViews() {
        contentView.addSubview(mainView, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(15),
            .trailing(-15)
        
        ])
    }
}
