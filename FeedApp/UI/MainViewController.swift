//
//  MainViewController.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 13.12.2021.
//

import UIKit

class MainViewController: UIViewController, FeedView {

    var delegate: FeedPresenter!
    
    var postLoaded: Bool = true
    
    private let feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = FeedPresenterImpl(view: self)
        
        view.backgroundColor = .systemGray6
        feedTableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.identifier)
        feedTableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        feedTableView.register(FooterCell.self, forCellReuseIdentifier: FooterCell.identifier)
        feedTableView.register(LinkCell.self, forCellReuseIdentifier: LinkCell.identifier)
        feedTableView.register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.identifier)
        
        delegate.loadNextPosts { [self] in
            feedTableView.delegate = self
            feedTableView.dataSource = self
            navigationController?.navigationBar.prefersLargeTitles = true
            title = "Home"
            
            view.addSubview(feedTableView, layoutAnchors: [
                .leading(0),
                .trailing(0),
                .bottom(0),
                .top(0)])
            
        }
    }
        
    
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0,3:
            return 70
        default:
            return UITableView.automaticDimension
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let delegate = delegate else {
            return 0
        }
        return delegate.getPostCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let delegate = delegate else {
            print("Delegate not found")
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as! HeaderCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier) as! TitleCell
            cell.titleTextView.text = delegate.getPostTitle(indexPath.section)
            return cell
//
//            case 2:
//                let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier) as! AlbumCell
//                cell.delegate = self
//                cell.albumHeight = 300
//                return cell
//
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: FooterCell.identifier) as! FooterCell
            return cell
        default:
            return UITableViewCell()
        }
        
//        switch delegate.getPostType(indexPath.section){
//        case .titleOnly:
//            break
//        case .link:
//            break
//        case .photo:
//            break
//        case .text:
//            break
//        case .video:
//            break
//        }
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard postLoaded else {
            return
        }
        let deltaOffset = scrollView.contentSize.height - scrollView.bounds.height - scrollView.contentOffset.y
        
        if deltaOffset <= 1000 {
            postLoaded = false
            delegate.loadNextPosts {
                self.feedTableView.reloadData()
                self.postLoaded = true
            }
        }
    }
}
extension MainViewController: AlbumDelegate {
    func album(_ album: UICollectionView, numberOfPhotosIn section: Int) -> Int {
        return 2
    }
    
    func album(_ album: UICollectionView, cellForPhotoAt indexPath: IndexPath) -> ImageCell {
        let cell = album.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.contentImageView.image = UIImage(named: "blond")
        return cell
    }
//    func album(_ album: UICollectionView, sizeForPhotoAt indexPath: IndexPath) -> CGSize {
//        <#code#>
//    }
    
}
