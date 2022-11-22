//
//  HeaderCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 10.02.2022.
//

import UIKit



final class HeaderCell: UITableViewCell {
    
    static public let identifier = "HeaderCell"
    
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        return view
    }()
    
    private let subredditImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemOrange
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let headerLabelButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let subredditNameButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.darkGray, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return button
    }()
    
    private let redditUserNameButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "More"), for: .normal)
        button.imageView?.tintColor = .clear
        return button
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        backgroundColor = .clear
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        subredditImageView.layoutIfNeeded()
        subredditImageView.layer.cornerRadius = subredditImageView.frame.width / 2
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        subredditImageView.image = nil
    }
    
    public func configureWith(_ dataView: FeedDataView) {
        self.redditUserNameButton.setTitle(dataView.user, for: .normal)
        self.subredditNameButton.setTitle(dataView.subreddit, for: .normal)
    }
    private func setupViews() {
        contentView.addSubview(mainView, layoutAnchors: [
            .leading(15),
            .trailing(-15),
            .top(10),
            .bottom(0)
        ])
        //
        //  subredditImageView
        //
        mainView.addSubview(subredditImageView, layoutAnchors: [
            .leading(10),
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 0.7, constant: 0),
            .centerY(0)
        ])
        subredditImageView.activate(layoutAnchors: [.relative(attribute: .width, relation: .equal, relatedTo: .height, multiplier: 1, constant: 0)], to: subredditImageView)
        
        //
        //  settingsButton
        //
        
        mainView.addSubview(settingsButton, layoutAnchors: [
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
        
        mainView.addSubview(headerLabelButtonsStackView, layoutAnchors: [
            .centerY(0)
        ])
        headerLabelButtonsStackView.activate(layoutAnchors: [
            .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 1, constant: 0),
            .relative(attribute: .left, relation: .equal, relatedTo: .right, multiplier: 1, constant: 10)
        ], to: subredditImageView)
        headerLabelButtonsStackView.activate(layoutAnchors: [
            .relative(attribute: .right, relation: .equal, relatedTo: .left, multiplier: 1, constant: 0)
        ], to: settingsButton)
        
        headerLabelButtonsStackView.addArrangedSubview(subredditNameButton)
        headerLabelButtonsStackView.addArrangedSubview(redditUserNameButton)
    }

}
