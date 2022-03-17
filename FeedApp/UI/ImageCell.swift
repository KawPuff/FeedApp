//
//  ImagesCollectionViewCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 18.12.2021.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    public static let identifier = "ImageCell"
    
    let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
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
