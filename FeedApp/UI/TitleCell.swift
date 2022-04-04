//
//  TitleCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 10.02.2022.
//

import UIKit

final class TitleCell: UITableViewCell {
    
    static public let identifier = "TitleCell"
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
//    let titleTextView: UITextView = {
//        let tv = UITextView()
//        tv.isEditable = false
//        tv.backgroundColor = .darkGray
//        tv.textContainerInset = .zero
//        tv.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
//        tv.isScrollEnabled = false
//        tv.font = .systemFont(ofSize: 21, weight: .semibold)
//        return tv
//    }()
    let titleTextView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
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
        contentView.addSubview(mainView, layoutAnchors: [
            .leading(15),
            .trailing(-15),
            .top(0),
            .bottom(0)
        ])
        mainView.addSubview(titleTextView, layoutAnchors: [
            .leading(10),
            .trailing(-10),
            .top(0),
            .bottom(0)
        ])
    }
}
