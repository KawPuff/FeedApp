//
//  AlbumCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 24.02.2022.
//

import UIKit

protocol AlbumDelegate: AnyObject {
    
    func album(_ album: UICollectionView, numberOfPhotosInCellBy index: Int) -> Int
    func album(_ album: UICollectionView, cellForImageAt indexPath: IndexPath, cellBy index: Int) -> AlbumImageCell
}

final class AlbumCell: UITableViewCell {
    
    static let identifier = "AlbumCell"
    
    var delegate: AlbumDelegate?
    var cellBy: Int?
    private var album: UICollectionView!
    
    private var albumFlowLayout: UICollectionViewFlowLayout!
    
    private var heightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAlbumFlowLayout()
        
        album = UICollectionView(frame: CGRect.zero, collectionViewLayout: albumFlowLayout)
        setupViews()
        backgroundColor = .clear
        album.register(AlbumImageCell.self, forCellWithReuseIdentifier: AlbumImageCell.identifier)
        album.delegate = self
        album.dataSource = self
        album.showsHorizontalScrollIndicator = false
        album.isPagingEnabled = true
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAlbumFlowLayout()
        setupViews()
        backgroundColor = .clear
        album = UICollectionView(frame: CGRect.zero)
        album.collectionViewLayout = albumFlowLayout
        album.register(AlbumImageCell.self, forCellWithReuseIdentifier: AlbumImageCell.identifier)
        album.delegate = self
        album.dataSource = self
        
    }

    private func setupAlbumFlowLayout(){
        albumFlowLayout = UICollectionViewFlowLayout()
        albumFlowLayout.scrollDirection = .horizontal
        albumFlowLayout.minimumLineSpacing = 2.0
        albumFlowLayout.minimumInteritemSpacing = 5.0
        
        
    }
    private func setupViews() {
        contentView.addSubview(album, layoutAnchors: [
            .bottom(0),
            .top(0),
            .leading(15),
            .trailing(-15)
        ])
        heightConstraint = NSLayoutConstraint(item: album!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        heightConstraint?.isActive = true
    }
   
    func setAlbumHeight(_ height: CGFloat){
        heightConstraint?.constant = height
    }
}
extension AlbumCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = delegate, let cellBy = self.cellBy else{
            return 0
            
        }
        return delegate.album(collectionView, numberOfPhotosInCellBy: cellBy)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 15, height: collectionView.frame.height - 15)
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AlbumImageCell
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6.0, options: [.curveEaseOut], animations: {
            cell.transform = .identity.scaledBy(x: 0.95, y: 0.95)
        }, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AlbumImageCell
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6.0, options: [.curveEaseOut], animations: {
            cell.transform = .identity
        }, completion: nil)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let delegate = delegate, let cellBy = self.cellBy else {
            return UICollectionViewCell()
        }
        return delegate.album(collectionView, cellForImageAt: indexPath, cellBy: cellBy)
    }
    
    
}
