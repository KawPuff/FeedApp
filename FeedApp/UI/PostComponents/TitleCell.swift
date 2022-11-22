//
//  TitleCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 10.02.2022.
//

import UIKit

final class TitleCell: UITableViewCell {
    
    static public let identifier = "TitleCell"
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 21, weight: .semibold)
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
    
    public func configureWith(_ dataView: FeedDataView) {
        title.text = dataView.title
    }
    private func setupViews() {
        contentView.addSubview(mainView, layoutAnchors: [
            .leading(15),
            .trailing(-15),
            .top(0),
            .bottom(0)
        ])
        mainView.addSubview(title, layoutAnchors: [
            .leading(10),
            .trailing(-10),
            .top(0),
            .bottom(0)
        ])
    }
}
