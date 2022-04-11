//
//  LinkCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 11.02.2022.
//

import UIKit

final class LinkCell: UITableViewCell {

    static let identifier: String = "LinkCell"
    
    var delegate: LinkOpenerDelegate?
    
    var urlString: String = ""
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let preview: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .orange
        iv.layer.cornerRadius = 12
        iv.isUserInteractionEnabled = true //Отвечает за доступ к событиям
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let titleBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()
    
    let domainTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10, weight: .semibold)

        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(previewPressed))
        preview.addGestureRecognizer(recognizer)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(previewPressed))
        preview.addGestureRecognizer(recognizer)
    }
    @objc func previewPressed(sender: AnyObject) {
        guard let url = URL(string: urlString), let delegate = delegate else {
            return
        }
        delegate.openLink(url: url)
    }
    private func setupViews() {
        
        contentView.addSubview(mainView, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(15),
            .trailing(-15)
        ])
        mainView.addSubview(preview, layoutAnchors: [
            .top(15),
            .bottom(-15),
            .leading(15),
            .trailing(-15)
        ])
        preview.addSubview(titleBackground, layoutAnchors: [
            .bottom(0),
            .leading(0),
            .trailing(0),
            .height(20)
        ])
        titleBackground.addSubview(domainTitle, layoutAnchors: [
            .bottom(0),
            .top(0),
            .leading(10),
            .trailing(-10)
        ])
    }
}
