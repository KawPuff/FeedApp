//
//  ImagesCollectionViewCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 18.12.2021.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    public static let identifier = "ImagesCollectionViewCell"
    
    let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(contentImageView, layoutAnchors: [
            .centerX(0),
            .centerY(0),
            .relative(attribute: .width, relation: .equal, relatedTo: .width, multiplier: 1, constant: 0),
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 1, constant: 0)
        ])
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            //
            //  contentImageView
            //
            contentImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            contentImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
            
        ])
    }
}
