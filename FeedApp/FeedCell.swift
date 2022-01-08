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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        return view
    }()
    let subredditImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let headerLabelButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .darkGray
        return stackView
    }()
    let subredditNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let redditUserNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor  = .systemPurple
        return button
        
    }()
    let contentHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        
        return view
    }()
    let commentsButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPurple
        return button
    }()
    
    let rateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        
        return view
    }()
    let rateStackView: UIStackView = {
       let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.layer.cornerRadius = 15
        sv.layer.masksToBounds = true
        
        return sv
    }()
    let upButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPurple
        return button
    }()
    let rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1.3k"
        label.textAlignment = .center
        label.backgroundColor = .systemRed
        return label
    }()
    let downButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPurple
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        headerLabelButtonsStackView.addArrangedSubview(subredditNameButton)
        headerLabelButtonsStackView.addArrangedSubview(redditUserNameButton)
        
        contentView.addSubview(mainView, [.relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)])
        mainView.addSubview(headerView)
        
        headerView.addSubview(subredditImageView)
        headerView.addSubview(headerLabelButtonsStackView)
        headerView.addSubview(settingsButton)
        
        cvLayout = UICollectionViewFlowLayout()
        imagesCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: cvLayout)
        cvLayout.scrollDirection = .horizontal
        imagesCollectionView.backgroundColor = .systemRed
        imagesCollectionView.showsHorizontalScrollIndicator = false
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.identifier)
        
        
        mainView.addSubview(contentHeaderLabel)
        
        
        mainView.addSubview(imagesCollectionView)
        
        mainView.addSubview(footerView)
        
        footerView.addSubview(commentsButton)
        footerView.addSubview(rateStackView)
        
        rateStackView.addArrangedSubview(downButton)
        rateStackView.addArrangedSubview(rateLabel)
        rateStackView.addArrangedSubview(upButton)
        
        configureConstraints()
        
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
        
        return (imagesCollectionView.frame.size.width - itemWidth) / 2
    }
    func configureConstraints() {
        NSLayoutConstraint.activate([
            //
            // mainView
            //
            mainView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -10),
            mainView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -10),
            mainView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            //
            // headerView
            //
            headerView.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            headerView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            headerView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.15),
            headerView.topAnchor.constraint(equalTo: mainView.topAnchor),
            //
            // subredditImageView
            //
            subredditImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            subredditImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 10),
            subredditImageView.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.7),
            subredditImageView.widthAnchor.constraint(equalTo: subredditImageView.heightAnchor),
            //
            // headerLabelButtonsStackView
            //
            headerLabelButtonsStackView.centerYAnchor.constraint(equalTo: subredditImageView.centerYAnchor),
            headerLabelButtonsStackView.leftAnchor.constraint(equalTo: subredditImageView.rightAnchor),
            headerLabelButtonsStackView.heightAnchor.constraint(equalTo: subredditImageView.heightAnchor),
            headerLabelButtonsStackView.rightAnchor.constraint(equalTo: settingsButton.leftAnchor),
            //
            // settingsButton
            //
            settingsButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -10),
            settingsButton.centerYAnchor.constraint(equalTo: subredditImageView.centerYAnchor),
            settingsButton.heightAnchor.constraint(equalTo: subredditImageView.heightAnchor),
            settingsButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor),
            //
            // footerView
            //
            footerView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            footerView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            footerView.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            footerView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.15),
            //
            // commentsButton
            //
            commentsButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            commentsButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 10),
            commentsButton.heightAnchor.constraint(equalTo: footerView.heightAnchor, multiplier: 0.6),
            commentsButton.widthAnchor.constraint(equalTo: commentsButton.heightAnchor),
            //
            // contentHeaderLabel
            //
            contentHeaderLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentHeaderLabel.bottomAnchor.constraint(equalTo: imagesCollectionView.topAnchor),
            contentHeaderLabel.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            contentHeaderLabel.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.15),
            //
            // imagesCollectionView
            //
            imagesCollectionView.topAnchor.constraint(equalTo: contentHeaderLabel.bottomAnchor),
            imagesCollectionView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            imagesCollectionView.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            imagesCollectionView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.55),
            //
            // rateStackView
            //
            rateStackView.centerYAnchor.constraint(equalTo: commentsButton.centerYAnchor),
            rateStackView.heightAnchor.constraint(equalTo: commentsButton.heightAnchor),
            rateStackView.widthAnchor.constraint(equalTo: commentsButton.widthAnchor, multiplier: 3),
            rateStackView.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -10)
        ])
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
