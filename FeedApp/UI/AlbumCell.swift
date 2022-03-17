//
//  AlbumCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 24.02.2022.
//

import UIKit
protocol AlbumDelegate: AnyObject {
    
    func album(_ album: UICollectionView, numberOfPhotosIn section: Int) -> Int
    func album(_ album: UICollectionView, cellForPhotoAt indexPath: IndexPath) -> ImageCell
    //func album(_ album: UICollectionView, sizeForPhotoAt indexPath: IndexPath) -> CGSize
}
class AlbumCell: UITableViewCell {
    
    static let identifier = "AlbumCell"
    var album: UICollectionView!
    var albumHeightConstraint: NSLayoutConstraint!
    
    var albumHeight: CGFloat = 0
    
    var albumFlowLayout: UICollectionViewFlowLayout!
    
    var delegate: AlbumDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAlbumFlowLayout()
        
        album = UICollectionView(frame: CGRect.zero, collectionViewLayout: albumFlowLayout)
        album.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        album.delegate = self
        album.dataSource = self
        
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAlbumFlowLayout()
        
        album = UICollectionView(frame: CGRect.zero, collectionViewLayout: albumFlowLayout)
        
        setupViews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
        
        albumHeightConstraint.constant = albumHeight
        albumFlowLayout.itemSize = CGSize(width: album.frame.size.width - 10, height: albumHeight - 10)
    }
    func setupAlbumFlowLayout(){
        albumFlowLayout = UICollectionViewFlowLayout()
        albumFlowLayout.scrollDirection = .horizontal
        
    }
    func setupViews() {
        contentView.addSubview(album, layoutAnchors: [
            .centerX(0),
            .centerY(0),
            .width(0)
        ])
        albumHeightConstraint = NSLayoutConstraint(item: album as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
        albumHeightConstraint.isActive = true
    }
}
extension AlbumCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = delegate else{
            return 0
        }
        return delegate.album(collectionView, numberOfPhotosIn: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let delegate = delegate else {
            return UICollectionViewCell()
        }
        return delegate.album(collectionView, cellForPhotoAt: indexPath)
    }
    
    
}
