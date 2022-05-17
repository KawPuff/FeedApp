//
//  ImageCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 09.05.2022.
//

import UIKit

final class ImageCell: UITableViewCell {
    
    public static let identifier = "ImageCell"
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 13
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var imageHeightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        backgroundColor = .clear
    }
    
    func setupImageHeight(height: CGFloat) {
        imageHeightConstraint?.constant = height
    }
    func setupImage(image: UIImage?) {
        cellImageView.image = image
    }
    
    private func setupViews() {
        contentView.addSubview(mainView, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(15),
            .trailing(-15)
        ])
        mainView.addSubview(cellImageView, layoutAnchors: [
            .top(10),
            .bottom(-10),
            .leading(10),
            .trailing(-10)
        ])
        imageHeightConstraint = NSLayoutConstraint(item: cellImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        imageHeightConstraint?.isActive = true
    }
}

