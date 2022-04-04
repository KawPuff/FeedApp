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
}
final class AlbumCell: UITableViewCell {
    
    static let identifier = "AlbumCell"
    var album: UICollectionView!
    
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
        
        album = UICollectionView(frame: CGRect.zero)
        album.collectionViewLayout = albumFlowLayout
        album.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.identifier)
        album.delegate = self
        album.dataSource = self
        
        setupViews()
    }

    func setupAlbumFlowLayout(){
        albumFlowLayout = UICollectionViewFlowLayout()
        albumFlowLayout.scrollDirection = .horizontal
        albumFlowLayout.itemSize = CGSize(width: 150, height: 180)
        albumFlowLayout.minimumLineSpacing = 2.0
        albumFlowLayout.minimumInteritemSpacing = 5.0
    }
    func setupViews() {
        contentView.addSubview(album, layoutAnchors: [
            .bottom(0),
            .top(0),
            .leading(15),
            .trailing(-15)
        ])
    }
}
extension AlbumCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = delegate else{
            return 0
            
        }
        return delegate.album(collectionView, numberOfPhotosIn: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 15, height: collectionView.frame.height - 15)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let delegate = delegate else {
            return UICollectionViewCell()
        }
        return delegate.album(collectionView, cellForPhotoAt: indexPath)
    }
    
    
}
