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
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 13
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let backgroundBlur: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private var imageHeightConsstraint: NSLayoutConstraint?
    private var backImageHeightConstraint: NSLayoutConstraint?
    
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
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
        backgroundImageView.image = nil
    }
    
    internal func configureWith(_ dataView: SingleImageDataView, heightWithTableRatio: CGFloat) {
        imageHeightConsstraint?.constant = heightWithTableRatio
        backImageHeightConstraint?.constant = heightWithTableRatio
    }

    internal func setupImage(image: UIImage?) {
        backgroundImageView.image = image
        cellImageView.image = image
    }
    
    private func setupViews() {
        contentView.addSubview(mainView, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(15),
            .trailing(-15)
        ])
        mainView.addSubview(backgroundImageView, layoutAnchors: [
            .top(10),
            .bottom(-10),
            .leading(10),
            .trailing(-10)
        ])
        backgroundImageView.addSubview(backgroundBlur, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(0),
            .trailing(0)
        ])
        backgroundImageView.addSubview(cellImageView, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(0),
            .trailing(0)
        ])
        imageHeightConsstraint = NSLayoutConstraint(item: cellImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        imageHeightConsstraint?.priority = .defaultHigh
        imageHeightConsstraint?.isActive = true
        
        backImageHeightConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        imageHeightConsstraint?.priority = .defaultHigh
        backImageHeightConstraint?.isActive = true

        
    }
}

