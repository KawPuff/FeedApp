//
//  TextCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 21.03.2022.
//

import UIKit

final class TextCell: UITableViewCell {
    
    static let identifier: String = "TextCell"
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    let text: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
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
    
    func setupViews(){
        contentView.addSubview(mainView, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(15),
            .trailing(-15)
        ])
        mainView.addSubview(text, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(10),
            .trailing(-10)
        ])
    }
}
