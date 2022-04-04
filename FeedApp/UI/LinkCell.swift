//
//  LinkCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 11.02.2022.
//

import UIKit

final class LinkCell: UITableViewCell {

    static let identifier = "LinkCell"
    
    let title: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.font = .systemFont(ofSize: 21, weight: .semibold)
        tv.backgroundColor = .systemTeal
        tv.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        
        return tv
    }()
    let linkView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
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
        
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()

        let rect = convert(linkView.frame, to: title).offsetBy(dx: 10, dy: 0)
        let exclutionPath = UIBezierPath(rect: rect)
        title.textContainer.exclusionPaths = [exclutionPath]
        
    }
    private func setupViews() {
        contentView.addSubview(title, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(10),
            .trailing(-20)
        ])
        contentView.addSubview(linkView, layoutAnchors: [
            .top(10),
            .trailing(-20),
            .height(100),
            .width(120)
        ])
        linkView.activate(layoutAnchors: [
            .relative(attribute: .bottom, relation: .lessThanOrEqual, relatedTo: .bottom, multiplier: 1, constant: -10)
        ], to: contentView)
    }
}
