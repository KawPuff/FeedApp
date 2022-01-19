//
//  MainViewController.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 13.12.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private let feedTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    
        return tableView
    }()
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        feedTableView.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.estimatedRowHeight = 100
        //navigationController?.navigationBar.prefersLargeTitles = true
        title = "Home"
        view.addSubview(feedTableView, layoutAnchors: [
            .leading(0),
            .trailing(0),
            .bottom(0),
            .top(0)])
    }

}
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier) as! FeedCell
        
        if (indexPath.row % 2 == 0) {
            let image = UIImage(named: "blond")!
            //cell.postType = .photoPost(image: image)
            cell.postImageViewConstraint.constant = (image.size.width / image.size.height) * tableView.frame.width
            cell.postImageView.image = UIImage(named: "blond")
        } else {
            //cell.postType = .textPost(text: )
            cell.postLabel.text = "Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body Body "
            //cell.postTextView.text = "YO yo yo yo yo yo yo YO yo yo yo yo yo yo"
            //cell.postTextViewConstraint.constant = 150
            //cell.postLabel.sizeToFit()
        }
         
        
        
//        cell.postType = .textPost(text: "Hooba booba")
//        cell.postLabelConstraint.constant = 100
        
        return cell
    }
    
    
}
