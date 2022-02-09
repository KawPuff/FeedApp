//
//  ImagesView.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 09.02.2022.
//

import UIKit

protocol AlbumViewDelegate: AnyObject {
    func albumView(numberOfItemsInAlbum albumView: AlbumView) -> Int
    func albumView(_ albumView: AlbumView, imageForItemAt index: Int) -> UIImage
}
class AlbumView: UIView {

    public var delegate: AlbumViewDelegate?
    
    var imagesCollectionView: UICollectionView!
    var cvLayout: UICollectionViewFlowLayout!
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.isEnabled = false
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cvLayout = UICollectionViewFlowLayout()
        cvLayout.scrollDirection = .horizontal
        imagesCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: cvLayout)
        imagesCollectionView.isPagingEnabled = true
        imagesCollectionView.showsHorizontalScrollIndicator = false
        addSubview(imagesCollectionView)
        addSubview(pageControl)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutIfNeeded()
        imagesCollectionView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        pageControl.frame = CGRect(x: 10, y: frame.height - 100, width: frame.width - 20, height: 100)
        configureCell()
    }
    
    private func configureCell() {
        cvLayout.itemSize = CGSize(width: imagesCollectionView.frame.width, height: imagesCollectionView.frame.height)
        cvLayout.minimumLineSpacing = 0
        cvLayout.minimumInteritemSpacing = 0
    }
}
extension AlbumView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = delegate?.albumView(numberOfItemsInAlbum: self) ?? 0
        return pageControl.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.identifier, for: indexPath)
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = .orange
        } else {
            cell.backgroundColor = .gray
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(round( scrollView.contentOffset.x / cvLayout.itemSize.width ))
    }
    
}
