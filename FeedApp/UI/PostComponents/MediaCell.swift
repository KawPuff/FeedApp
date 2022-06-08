//
//  MediaCell.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 25.04.2022.
//

import UIKit
import AVFoundation

class MediaCell: UITableViewCell {
    
    public static let identifier: String = "MediaCell"
    
    var mediaHeight: CGFloat {
        get{
            return heightConstraint.constant
        }
        set {
            heightConstraint.constant = newValue
        }
    }
    private var heightConstraint: NSLayoutConstraint!
    
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let mediaView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = .black
        return view
    }()
    private let buttonsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    private let volumeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Volume Off"), for: .normal)
        return button
    }()
    
    func setupMediaUrl(_ url: String) {
        guard let url = URL(string: url) else {
            return
        }
        player = AVPlayer(url: url)
        player.isMuted = true
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspect
        mediaView.layer.addSublayer(playerLayer!)
        
        player.play()
       
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .clear
        volumeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(volumeButtonPressed)))
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default, options: [])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerLayer.player = nil
    }
    
    private func setupViews() {
        contentView.addSubview(mainView, layoutAnchors: [
            .top(0),
            .bottom(0),
            .leading(15),
            .trailing(-15)
        
        ])
        mainView.addSubview(mediaView, layoutAnchors: [
            .top(10),
            .bottom(-10),
            .leading(10),
            .trailing(-10)
        ])
        
        heightConstraint = NSLayoutConstraint(item: mediaView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
       
        mainView.addSubview(buttonsView,layoutAnchors: [
            .top(10),
            .bottom(-10),
            .leading(10),
            .trailing(-10)
        ])
        buttonsView.addSubview(volumeButton, layoutAnchors: [
            .bottom(-5),
            .trailing(-5),
            .height(70),
            .width(70)
        ])
    }
    @objc func volumeButtonPressed() {
        player.isMuted = !player.isMuted
        volumeButton.setImage(player.isMuted ? UIImage(named: "Volume Off") : UIImage(named: "Volume On"), for: .normal)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
        playerLayer?.frame = mediaView.bounds
    }
    
    
    
}
