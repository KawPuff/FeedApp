//
//  FeedCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 16.12.2021.
//

import UIKit


class FeedCell: UITableViewCell {
    
    static public let identifier = "FeedCell"
    
    public var postImageViewConstraint: NSLayoutConstraint!
    
    public var albumView: AlbumView = {
        let imageView = AlbumView()
        imageView.backgroundColor = .systemRed
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        //imageView.isHidden = true
        return imageView
    }()
    var postTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .systemTeal
        tv.font = .systemFont(ofSize: 14, weight: .regular)
        return tv
    }()
    let linkView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = .orange
        return view
    }()
    let mainView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
        return view
    }()
    let header: FeedCellHeader = {
        let view = FeedCellHeader()
        view.backgroundColor = .systemPink
        return view
    }()
    
    let titleTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .systemTeal
        tv.isEditable = false
        
        tv.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 21, weight: .semibold)
        return tv
    }()
    
    var imagesCollectionView: UICollectionView?

    let footer: FeedCellFooter = {
        let view = FeedCellFooter()
        view.backgroundColor = .systemPink
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray6
        albumView.delegate = self
        addSubviewsAndConfigureConstraints()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviewsAndConfigureConstraints()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layoutIfNeeded() // Принудительное расположение layers
        
        let convertedRect = linkView.convert(linkView.bounds, to: titleTextView) // Расположение и размеры в координатном пространстве titleTextView
        let exclusionPath = UIBezierPath(rect: convertedRect)
        titleTextView.textContainer.exclusionPaths = [exclusionPath]
    }
    
    func addSubviewsAndConfigureConstraints() {
        
        //
        //  mainView
        //
        
        contentView.addSubview(mainView, layoutAnchors: [
            .top(10),
            .trailing(-10),
            .bottom(-10),
            .leading(10)])
        
        //
        //  headerView
        //
        
        mainView.addSubview(header, layoutAnchors: [
            .top(0),
            .leading(0),
            .trailing(0),
            .height(70)])
        
        //
        //  footerView
        //
        
        mainView.addSubview(footer, layoutAnchors: [
            .bottom(0),
            .leading(0),
            .trailing(0),
            .height(70)
        ])
        
        //
        //  postImageView
        //
        
        mainView.addSubview(albumView, layoutAnchors: [
            .leading(10),
            .trailing(-10)
        ])
        postImageViewConstraint = NSLayoutConstraint(from: albumView, to: nil, anchor: .height(0))
        postImageViewConstraint.isActive = true
        
        albumView.activate(layoutAnchors: [
            .relative(attribute: .bottom, relation: .equal, relatedTo: .top, multiplier: 1, constant: -10)
        ], to: footer)
        
        //
        //  postLabel
        //
        mainView.addSubview(postTextView, layoutAnchors: [
            .leading(10),
            .trailing(-10)
        
        ])
        
        postTextView.activate(layoutAnchors: [
            .relative(attribute: .bottom, relation: .equal, relatedTo: .top, multiplier: 1, constant: -10)
        ], to: albumView)
        
        //
        //  titleTextView
        //
        
        mainView.addSubview(titleTextView, layoutAnchors: [
            .leading(10),
            .trailing(-10)
        ])
        
        titleTextView.activate(layoutAnchors: [
            .relative(attribute: .top, relation: .equal, relatedTo: .bottom, multiplier: 1, constant: 0)
        ], to: header)
        
        titleTextView.activate(layoutAnchors: [
            .relative(attribute: .bottom, relation: .equal, relatedTo: .top, multiplier: 1, constant: 0)
        ], to: postTextView)
    }
    func setCellImage(_ image: UIImage, imageRatio ratio: CGFloat) {
        postImageViewConstraint.constant = ratio
        //postImageView.image = image
    }
    func setCellText(_ text: String){
        postTextView.isScrollEnabled = false //for self-sizing text
        postTextView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
    func setCellLink() {
        mainView.addSubview(linkView, layoutAnchors: [
            .trailing(-10),
            .height(100),
            .width(120)
        ])
        linkView.activate(layoutAnchors: [
            .relative(attribute: .top, relation: .equal, relatedTo: .bottom, multiplier: 1, constant: 10)
        ], to: header)
        linkView.activate(layoutAnchors: [
            .relative(attribute: .bottom, relation: .lessThanOrEqual, relatedTo: .top, multiplier: 1, constant: -10)
        ], to: postTextView)
        titleTextView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        //titleTextView.textContainer.exclusionPaths = [exclusionPath]
    }
}

extension FeedCell: AlbumViewDelegate {
    func albumView(numberOfItemsInAlbum albumView: AlbumView) -> Int {
        return 5
    }
    
    func albumView(_ albumView: AlbumView, imageForItemAt index: Int) -> UIImage {
        return UIImage()
    }
    
    
}
