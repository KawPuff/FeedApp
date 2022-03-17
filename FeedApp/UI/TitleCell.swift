//
//  TitleCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 10.02.2022.
//

import UIKit

class TitleCell: UITableViewCell {
    
    static public let identifier = "TitleCell"
    
    let titleTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .systemTeal
        tv.isEditable = false
        
        tv.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 21, weight: .semibold)
        return tv
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    private func setupViews() {
        contentView.addSubview(titleTextView, layoutAnchors: [
            .leading(15),
            .trailing(-15),
            .top(0),
            .bottom(0)
        ])
    }
}
