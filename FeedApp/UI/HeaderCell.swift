//
//  HeaderCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 10.02.2022.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    static public let identifier = "HeaderCell"
    
    public let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        return view
    }()
    
    public let subredditImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    public let headerLabelButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    public let subredditNameButton: UILabel = {
        let label = UILabel()
        label.text = "r/Subreddit"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        
        return label
    }()
    
    public let redditUserNameButton: UIButton = {
        let button = UIButton()
        button.setTitle("   u/User", for: .normal)
        button.setTitleColor(.darkText, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        return button
    }()
    
    public let settingsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor  = .systemPurple
        return button
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        subredditImageView.layoutIfNeeded()
        subredditImageView.layer.cornerRadius = subredditImageView.frame.width / 2
    }
    func setupViews() {
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
            .relative(attribute: .left, relation: .equal, relatedTo: .right, multiplier: 1, constant: 0)
        ], to: subredditImageView)
        headerLabelButtonsStackView.activate(layoutAnchors: [
            .relative(attribute: .right, relation: .equal, relatedTo: .left, multiplier: 1, constant: 0)
        ], to: settingsButton)
        
        headerLabelButtonsStackView.addArrangedSubview(subredditNameButton)
        headerLabelButtonsStackView.addArrangedSubview(redditUserNameButton)
    }

}
