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
        return view
    }()
    let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 14, weight: .medium)
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
    
    func setupViews(){
        contentView.addSubview(mainView, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(15),
            .trailing(-15)
        ])
        mainView.addSubview(textView, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(10),
            .trailing(-10)
        ])
    }
}
