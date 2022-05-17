//
//  MainViewController.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 13.12.2021.
//

import UIKit
import SafariServices

protocol FeedView: AnyObject {
    func attachPresenter(_ presenter: FeedPresenter)
}

final class MainViewController: UIViewController, FeedView {

    private var presenter: FeedPresenter!
    private var dataViews: [FeedDataView] = []
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
        feedTableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        view.addSubview(feedTableView, layoutAnchors: [
            .leading(0),
            .trailing(0),
            .bottom(0),
            .top(0)])
        
        presenter.fetchNextPosts {  [unowned self] response in
            if let data = response.data {
                dataViews += data
                feedTableView.reloadData()
            }
            if let error = response.error {
                print(error)
            }
        }
    }
    
    func attachPresenter(_ presenter: FeedPresenter) {
        self.presenter = presenter
    }
    
}

// MARK: - TableView Delegates
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let headerRow = 0, titleRow = 1, contentRow = 2, footerRow = 3
        switch indexPath.row {
        case headerRow, footerRow:
            return 70
            
        case titleRow:
            return UITableView.automaticDimension
            
        case contentRow:
            switch dataViews[indexPath.section].type {
            case .titleOnly:
                return 0
                
            default:
                return UITableView.automaticDimension
            }
            
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataViews.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerRow = 0, titleRow = 1, contentRow = 2, footerRow = 3
        switch indexPath.row {
            case headerRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as! HeaderCell
            cell.redditUserNameButton.setTitle(dataViews[indexPath.section].user, for: .normal)
            cell.subredditNameButton.setTitle(dataViews[indexPath.section].subreddit, for: .normal)
            return cell
            
            case titleRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier) as! TitleCell
            cell.titleTextView.text = dataViews[indexPath.section].title
            return cell
            
            case contentRow:
            switch dataViews[indexPath.section].type {
                case .link:
                let cell = tableView.dequeueReusableCell(withIdentifier: LinkCell.identifier) as! LinkCell
                let linkDataView = dataViews[indexPath.section] as! LinkDataView
                cell.delegate = self
                cell.urlString = linkDataView.url
                cell.domainTitle.text = linkDataView.domainTitle
                
                let height = CGFloat(linkDataView.previewImageHeight)
                let width = CGFloat(linkDataView.previewImageWidth)
                cell.previewHeight = calcHeightWithTableViewRatio(size: CGSize(width: width, height: height))
                cell.setupPreviewImage(nil)
                ImageLoader.shared.load(by: linkDataView.previewImageUrl) { image in
                    cell.setupPreviewImage(image)
                }
                return cell
                
                case .image:
                let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier) as! ImageCell
                let imageDataView = dataViews[indexPath.section] as! SingleImageDataView
                cell.setupImageHeight(height: calcHeightWithTableViewRatio(size: CGSize(width: imageDataView.imageWidth, height: imageDataView.imageHeight)))
                cell.setupImage(image: nil)
                ImageLoader.shared.load(by: imageDataView.imageUrl) { image in
                    cell.setupImage(image: image)
                }
                return cell
                
                case .album:
                let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.identifier) as! AlbumCell
                let albumDataView = dataViews[indexPath.section] as! AlbumDataView
                cell.delegate = self
                cell.cellBy = indexPath.section
                
                let height = CGFloat(albumDataView.imagesDataView.first?.height ?? 0)
                let width = CGFloat(albumDataView.imagesDataView.first?.width ?? 0)
                cell.setAlbumHeight(calcHeightWithTableViewRatio(size: CGSize(width: width, height: height)))
                return cell
                    
                case .text:
                let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifier) as! TextCell
                let textDataView = dataViews[indexPath.section] as! TextDataView
                cell.text.text = textDataView.text
                return cell
                
                default:
                return UITableViewCell()
                }
            
        case footerRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: FooterCell.identifier) as! FooterCell
            cell.backgroundColor = .clear
            cell.commentsCountLabel.text = dataViews[indexPath.section].commentsCount
            cell.rateLabel.text = dataViews[indexPath.section].score
            
            return cell
            
            default:
                return UITableViewCell()
        }

    }
    private func calcHeightWithTableViewRatio(size: CGSize) -> CGFloat{
        guard size.height != 0 && size.width != 0 else {
            return size.height
        }
        let widthRatio = view.frame.width / size.width
        let heightRatio = view.frame.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        return size.height * scaleFactor
    }
    

    
}
// MARK: - AlbumDelegate
extension MainViewController: AlbumDelegate {
    func album(_ album: UICollectionView, numberOfPhotosInCellBy index: Int) -> Int {
        return (dataViews[index] as! AlbumDataView).imagesDataView.count
    }
    func album(_ album: UICollectionView, cellForImageAt indexPath: IndexPath, cellBy index: Int) -> AlbumImageCell {
        let cell = album.dequeueReusableCell(withReuseIdentifier: AlbumImageCell.identifier, for: indexPath) as! AlbumImageCell
        let albumData = dataViews[index] as! AlbumDataView
        cell.contentImageView.image = nil
        ImageLoader.shared.load(by: albumData.imagesDataView[indexPath.item].imageUrl) { image in
            cell.contentImageView.image = image
        }
        return cell
    }
}

extension MainViewController: LinkOpenerDelegate {
    func openLink(url: URL) {
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
    
    
}
