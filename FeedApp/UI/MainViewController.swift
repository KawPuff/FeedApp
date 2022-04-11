//
//  MainViewController.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 13.12.2021.
//

import UIKit
import SafariServices

final class MainViewController: UIViewController, FeedView {

    var presenter: FeedPresenter!
    
    private var postsLoaded: Bool = true
    
    private let feedTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        tableView.layer.masksToBounds = false
        tableView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        tableView.layer.shadowOpacity = 0.5
        tableView.layer.shadowRadius = 50
        tableView.layer.shadowOffset = .init(width: 0, height: 10)
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FeedPresenterImpl(view: self)
        
        view.backgroundColor = .white
        feedTableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.identifier)
        feedTableView.register(FooterCell.self, forCellReuseIdentifier: FooterCell.identifier)
        feedTableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        feedTableView.register(TextCell.self, forCellReuseIdentifier: TextCell.identifier)
        feedTableView.register(LinkCell.self, forCellReuseIdentifier: LinkCell.identifier)
        feedTableView.register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.identifier)
        
        presenter.loadNextPosts { [self] in
            feedTableView.delegate = self
            feedTableView.dataSource = self
            view.addSubview(feedTableView, layoutAnchors: [
                .leading(0),
                .trailing(0),
                .bottom(0),
                .top(0)])
        }
    }
    
}

// MARK: - TableView Delegates
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
  // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let presenter = presenter else {
            return 0
        }
        
        // Configure header and footer heights
        
        switch indexPath.row {
        
        case 0, 3:
            return 70
        case 1:
            return UITableView.automaticDimension
        case 2:
            
            // Configure content cells
            
            switch presenter.getPostType(indexPath.section){
                
            case .titleOnly:
                return 0
            case .link:
                return 150
            case .photo:
                return UITableView.automaticDimension
//                let imgSize = presenter.getImageSizeAt(index: indexPath.section)
//                let ratio = imgSize.height / tableView.frame.height
//
//                return imgSize.height * ratio
                
            default:
                return UITableView.automaticDimension
            }
            
        default:
            return UITableView.automaticDimension
        }
        
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = presenter else {
            return 0
        }
        
        return presenter.getPostCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = presenter else {
            return 0
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
            
            case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as! HeaderCell
            cell.backgroundColor = .clear
            
            // Check if avatarImage already exisits in uitableview cell cache
                // Try to get image from cache
            if let imageFromCache = cell.avatarCache.object(forKey: presenter.getSubredditName(indexPath.section) as AnyObject) as? UIImage {
                cell.subredditImageView.image = imageFromCache
                
            } else {
            
            // Otherwise download image
                presenter.getSubredditImage(indexPath.section) { image in
                    guard let image = image else {
                        return
                    }
                    //Set image to cache with key
                    cell.avatarCache.setObject(image, forKey: presenter.getSubredditName(indexPath.section) as AnyObject)
                    cell.subredditImageView.image = image
                }
                
            }
            
            cell.redditUserNameButton.setTitle(presenter.getUsername(indexPath.section), for: .normal)
            cell.subredditNameButton.setTitle(presenter.getSubredditName(indexPath.section), for: .normal)
            return cell
            
            case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier) as! TitleCell
            cell.titleTextView.text = presenter.getPostTitle(indexPath.section)
            cell.backgroundColor = .clear
            
            return cell
            // FIXME: Configure for different types of posts
            case 2:
            
            switch presenter.getPostType(indexPath.section) {
            
            case .link:
                let cell = tableView.dequeueReusableCell(withIdentifier: LinkCell.identifier) as! LinkCell
                cell.backgroundColor = .clear
                cell.domainTitle.text = "www.google.com"
                cell.delegate = self
                return cell
            case .titleOnly:
                return UITableViewCell()
                
            case .photo:
                    
                let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier) as! AlbumCell
                cell.delegate = self
                
                let imgSize = presenter.getImageSizeAt(index: indexPath.section)
                let ratio = imgSize.height / tableView.frame.height
                
                
                cell.setAlbumHeight(imgSize.height * ratio)
                
                cell.backgroundColor = .clear
                    
                return cell
                    
            case .text:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier) as! TextCell
                cell.textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                cell.backgroundColor = .clear
                return cell
            default:
                break
                    
                }
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: FooterCell.identifier) as! FooterCell
            cell.backgroundColor = .clear
                
            return cell
            
            default:
                return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard postsLoaded else {
            return
        }
        
        let deltaOffset = scrollView.contentSize.height - scrollView.bounds.height - scrollView.contentOffset.y
        
        if deltaOffset <= 1000 {
            postsLoaded = false
            presenter.loadNextPosts {
                self.feedTableView.reloadData()
                self.postsLoaded = true
            }
        }
    }
    
    

    
}
// MARK: - AlbumDelegate
extension MainViewController: AlbumDelegate {
    func album(_ album: UICollectionView, numberOfPhotosIn section: Int) -> Int {
        return 2
    }
    
    func album(_ album: UICollectionView, cellForPhotoAt indexPath: IndexPath) -> ImageCell {
        let cell = album.dequeueReusableCell(withReuseIdentifier: ImageCell.identifier, for: indexPath) as! ImageCell
        cell.contentImageView.image = UIImage(named: "blond")
        
        return cell
    }
    
}

extension MainViewController: LinkOpenerDelegate {
    func openLink(url: URL) {
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    
}
