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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        feedTableView.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        RedditManager.shared.getPosts(subreddit: "", limit: 0) { result in
            
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Home"
        view.addSubview(feedTableView, layoutAnchors: [.leading(0), .trailing(0), .bottom(0), .relative(attribute: .height, relation: .equal, relatedTo: .height, multiplier: 0.8, constant: 0)])
        
    }

}
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 1.2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier) as! FeedCell
        return cell
    }
    
    
}
