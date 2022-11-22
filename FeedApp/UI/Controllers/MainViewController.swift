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
        feedTableView.register(MediaCell.self, forCellReuseIdentifier: MediaCell.identifier)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.prefetchDataSource = self
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
            cell.configureWith(dataViews[indexPath.section])
            return cell
            
            case titleRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier) as! TitleCell
            cell.configureWith(dataViews[indexPath.section])
            return cell
            
            case contentRow:
            switch dataViews[indexPath.section].type {
            case .link:
                let cell = tableView.dequeueReusableCell(withIdentifier: LinkCell.identifier) as! LinkCell
                let linkDataView = dataViews[indexPath.section] as! LinkDataView
                
                let height = CGFloat(linkDataView.previewImageHeight)
                let width = CGFloat(linkDataView.previewImageWidth)
                let heightWithRatio = calcHeightWithTableViewRatio(size: CGSize(width: width, height: height))
                
                cell.configureWith(linkDataView, heightWithTableRatio: heightWithRatio, delegate: self)
                presenter.fetchImage(by: linkDataView.previewImageUrl) { image in
                    cell.setupImage(image)
                }
                return cell
                
            case .image:
                let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier) as! ImageCell
                let imageDataView = dataViews[indexPath.section] as! SingleImageDataView
                let height = CGFloat(imageDataView.imageHeight)
                let width = CGFloat(imageDataView.imageWidth)
                let heightWithRatio = calcHeightWithTableViewRatio(size: CGSize(width: width, height: height))
                cell.configureWith(imageDataView, heightWithTableRatio: heightWithRatio)
                
                presenter.fetchImage(by: imageDataView.imageUrl) { image in
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
            case .media:
                let cell = tableView.dequeueReusableCell(withIdentifier: MediaCell.identifier) as! MediaCell
                let mediaDataView = dataViews[indexPath.section] as! MediaDataView
                let height = CGFloat(mediaDataView.height)
                let width = CGFloat(mediaDataView.width)
                cell.mediaHeight = calcHeightWithTableViewRatio(size: CGSize(width: width, height: height))
                cell.setupMediaUrl(mediaDataView.url)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellNumberToPreload = 10
        if indexPath.section == tableView.numberOfSections - cellNumberToPreload {
            presenter.fetchNextPosts { [weak self] responce in
                guard let self = self else { return }
                if let data = responce.data {
                    self.dataViews += data
                    tableView.reloadData()
                }
                
                if let error = responce.error {
                    print(error)
                    return
                }
                
            }
        }
    }
    private func calcHeightWithTableViewRatio(size: CGSize) -> CGFloat{
        guard size.height != 0 && size.width != 0 else {
            return size.height
        }
        let widthRatio = view.frame.width / size.width
        let heightRatio = view.frame.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        if size.height > size.width {
            return size.width * scaleFactor
        }
        return size.height * scaleFactor
    }
    

    
}
// MARK: - UITableViewDataSourcePrefetching

extension MainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            switch dataViews[indexPath.section].type {
            case .image:
                let url = (dataViews[indexPath.section] as! SingleImageDataView).imageUrl
                ImageLoader.shared.load(by: url, completion: nil)
                break
            case .media:
                /* Prefetch media cells */
                break
            case .album:
                (dataViews[indexPath.section] as! AlbumDataView).imagesDataView.forEach {
                    ImageLoader.shared.load(by: $0.imageUrl, completion: nil)
                }
                break
            case .link:
                let url = (dataViews[indexPath.section] as! LinkDataView).previewImageUrl
                ImageLoader.shared.load(by: url, completion: nil)
                break
            default:
                break
            }
        }
    }
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            switch dataViews[indexPath.section].type {
            case .image:
                let url = (dataViews[indexPath.section] as! SingleImageDataView).imageUrl
                ImageLoader.shared.cancelLoad(by: url)
                break
            case .media:
               /* Cancel load for media cells */
                break
            case .album:
                (dataViews[indexPath.section] as! AlbumDataView).imagesDataView.forEach {
                    ImageLoader.shared.cancelLoad(by: $0.imageUrl)
                }
                break
            case .link:
                let url = (dataViews[indexPath.section] as! LinkDataView).previewImageUrl
                ImageLoader.shared.cancelLoad(by: url)
                break
            default:
                break
            }
        }
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

