//
//  FeedCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 16.12.2021.
//

import UIKit

class FeedCell: UITableViewCell {
    
    static public let identifier = "FeedCell"
    
    private var cvLayout: UICollectionViewFlowLayout!
    
    let mainView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
        return view
    }()
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()
    let subredditImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let headerLabelButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .darkGray
        return stackView
    }()
    let subredditNameButton: UIButton = {
        let button = UIButton()
        return button
    }()
    let redditUserNameButton: UIButton = {
        let button = UIButton()
        return button
    }()
    let settingsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor  = .systemPurple
        return button
        
    }()
    let contentHeaderLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemPurple
        
        return label
    }()
    var imagesCollectionView: UICollectionView!
    
    let contentImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        
        return view
    }()
    let commentsButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemPurple
        return button
    }()
    
    let rateView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
        return view
    }()
    let rateStackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.layer.cornerRadius = 15
        sv.layer.masksToBounds = true
        
        return sv
    }()
    let upButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        return button
    }()
    let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "1.3k"
        label.textAlignment = .center
        label.backgroundColor = .systemRed
        return label
    }()
    let downButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPurple
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cvLayout = UICollectionViewFlowLayout()
        imagesCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: cvLayout)
        cvLayout.scrollDirection = .horizontal
        imagesCollectionView.backgroundColor = .systemRed
        imagesCollectionView.showsHorizontalScrollIndicator = false
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.identifier)
        
        addSubviewsAndConfigureConstraints()
        
    }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureItemSize()
    }
    
// NOTE: imagesCollectionView configuring layout
    
    func configureItemSize(){
        let inset = calculateSectionInset()
        cvLayout.itemSize = CGSize(width: imagesCollectionView.frame.width - inset * 2, height: imagesCollectionView.frame.height * 0.8)
        cvLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    func calculateSectionInset() -> CGFloat {
        let itemWidth = imagesCollectionView.frame.width * 0.8
        
        return (imagesCollectionView.frame.width - itemWidth) / 2
    }
    func addSubviewsAndConfigureConstraints() {
        
        //
        //  mainView
        //
        
        contentView.addSubview(mainView, layoutAnchors: [
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 1, constant: -10),
            .relative(attribute: .width, relation: .equal, relatedTo: .width, multiplier: 1, constant: -10),
            .centerX(0),
            .centerY(0)])
        
        //
        //  headerView
        //
        
        mainView.addSubview(headerView, layoutAnchors: [
            .top(0),
            .relative(attribute: .width, relation: .equal, relatedTo: .width, multiplier: 1, constant: 0),
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 0.15, constant: 0),
            .centerX(0)])
        
        //
        //  subredditImageView
        //
        
        headerView.addSubview(subredditImageView, layoutAnchors: [
            .leading(10),
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 0.7, constant: 0),
            .centerY(0)
        ])
        subredditImageView.activate(layoutAnchors: [.relative(attribute: .width, relation: .equal, relatedTo: .height, multiplier: 1, constant: 0)], to: subredditImageView)
        
        //
        //  settingsButton
        //
        
        headerView.addSubview(settingsButton, layoutAnchors: [
            .trailing(-10),
            .centerY(0)
        ])
        settingsButton.activate(layoutAnchors: [
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 1, constant: 0)
        ], to: subredditImageView)
        settingsButton.activate(layoutAnchors: [
            .relative(attribute: .width, relation: .equal, relatedTo: .height, multiplier: 1, constant: 0)
        ], to: settingsButton)
        
        //
        //  headerLabelButtonsStackView
        //
        
        headerView.addSubview(headerLabelButtonsStackView, layoutAnchors: [
            .centerY(0)
        ])
        headerLabelButtonsStackView.activate(layoutAnchors: [
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 1, constant: 0),
            .relative(attribute: .left, relation: .equal, relatedTo: .right, multiplier: 1, constant: 0)
        ], to: subredditImageView)
        headerLabelButtonsStackView.activate(layoutAnchors: [
            .relative(attribute: .right, relation: .equal, relatedTo: .left, multiplier: 1, constant: 0)
        ], to: settingsButton)
        
        headerLabelButtonsStackView.addArrangedSubview(subredditNameButton)
        headerLabelButtonsStackView.addArrangedSubview(redditUserNameButton)
        
        //
        //  footerView
        //
        
        mainView.addSubview(footerView, layoutAnchors: [
            .centerX(0),
            .bottom(0),
            .relative(attribute: .width, relation: .equal, relatedTo: .width, multiplier: 1, constant: 0),
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 0.15, constant: 0)
        ])
        
        //
        //  commentsButton
        //
        
        footerView.addSubview(commentsButton, layoutAnchors: [
            .leading(10),
            .centerY(0),
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 0.6, constant: 0)
        ])
        commentsButton.activate(layoutAnchors: [
            .relative(attribute: .width, relation: .equal, relatedTo: .height, multiplier: 1, constant: 0)
        ], to: commentsButton)
        
        //
        //  contentHeaderLabel
        //
        
        mainView.addSubview(contentHeaderLabel, layoutAnchors: [
            .relative(attribute: .width, relation: .equal, relatedTo: .width, multiplier: 1, constant: 0),
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 0.15, constant: 0)
        ])
        contentHeaderLabel.activate(layoutAnchors: [
            .relative(attribute: .top, relation: .equal, relatedTo: .bottom, multiplier: 1, constant: 0),
        ], to: headerView)
        
        //
        //  imagesCollectionView
        //
        
        mainView.addSubview(imagesCollectionView, layoutAnchors: [
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 0.55, constant: 0),
            .relative(attribute: .width, relation: .equal, relatedTo: .width, multiplier: 1, constant: 0)
        ])
        imagesCollectionView.activate(layoutAnchors: [
            .relative(attribute: .top, relation: .equal, relatedTo: .bottom, multiplier: 1, constant: 0)
        ], to: contentHeaderLabel)
        imagesCollectionView.activate(layoutAnchors: [
            .relative(attribute: .bottom, relation: .equal, relatedTo: .top, multiplier: 1, constant: 0)
        ], to: footerView)
        
        //
        //  rateStackView
        //
        
        footerView.addSubview(rateStackView, layoutAnchors: [
            .centerY(0),
            .trailing(-10)
        ])
        
        
        rateStackView.activate(layoutAnchors: [
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 1, constant: 0),
            .relative(attribute: .width, relation: .equal, relatedTo: .width, multiplier: 3, constant: 0)
        ], to: commentsButton)
        
        rateStackView.addArrangedSubview(downButton)
        rateStackView.addArrangedSubview(rateLabel)
        rateStackView.addArrangedSubview(upButton)
        
    }
}

extension FeedCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.identifier, for: indexPath) as! ImagesCollectionViewCell
        cell.contentImageView.backgroundColor = indexPath.row % 2 == 0 ? .systemOrange : .systemGreen
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Some functionality to make paging
    }
    
}
