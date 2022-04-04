//
//  NetworkingManager.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 13.12.2021.
//

import UIKit

protocol NetworkManager🌐 {
    
    static var shared: NetworkManager🌐 { get }
    func downloadImage(urlString: String, _ completion:  ((UIImage?) -> Void)?)
    func getPosts(subreddit: String, limit: Int, after itemName: String?,_ completion: @escaping (Result<Listing>) -> Void)
    func getSubredditInfo(subreddit: String, _ completion: @escaping (String) -> Void)
}
class RedditManager: NetworkManager🌐 {
    
    private init() {
        
    }
    
    public static var shared: NetworkManager🌐 = RedditManager()
    
    func downloadImage(urlString: String, _ completion:  ((UIImage?) -> Void)?){
        guard let url = URL(string: urlString) else {
            completion?(nil)
            return
        }
        
        URLSession.shared.downloadTask(with: url) { url, _, error in
            guard error == nil else {
                print(error?.localizedDescription)
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            
            guard let url = url, let imageData = try? Data(contentsOf: url) else{
                print("Error image fetching")
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion?(UIImage(data: imageData))
            }
        }.resume()
    }
    func getPosts(subreddit: String, limit: Int = 25, after itemName: String? = nil, _ completion: @escaping (Result<Listing>) -> Void) {
        let itemName = itemName ?? ""
        
        let urlString = "https://www.reddit.com/r/\(subreddit).json?limit=\(limit)" + (itemName.isEmpty ? "" : "&after=" + itemName)
        guard let url = URL(string: urlString) else {
            completion(.failure("Url not found"))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _ , error in
            if let error = error {
                completion(.failure(error.localizedDescription))
                return
            }
            guard let data = data else {
                completion(.failure("No data found"))
                return
            }
            guard let object = try? JSONSerialization.jsonObject(with: data, options: []) else {
                completion(.failure("Error serialize json object."))
                return
            }
            guard let jsonDictionary = object as? JSONDictionary, let listingJson = jsonDictionary["data"] as? JSONDictionary else {
                completion(.failure("Error creating jsonDictionary"))
                return
            }
            
            DispatchQueue.main.async {
                let listing = Listing(json: listingJson)
                completion(.success(listing))
            }
            
        }.resume()
    }
    
    func getSubredditInfo(subreddit: String, _ completion: @escaping (String) -> Void){
        guard let url = URL(string: "https://www.reddit.com/\(subreddit)/about.json?") else {
            completion("")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else{
                DispatchQueue.main.async {
                    completion("error")
                }
                return
            }
            guard let data = data, let object = try? JSONSerialization.jsonObject(with: data, options: [])  else {
                DispatchQueue.main.async {
                    completion("error parsae data")
                }
                return
            }
            guard let jsonDictionary = object as? JSONDictionary, let listingJson = jsonDictionary["data"] as? JSONDictionary else {
                DispatchQueue.main.async {
                    completion("error fetch info")
                    
                }
                return
            }
            
            DispatchQueue.main.async {
                let listing = SubredditInfo(from: listingJson)
                completion(listing.avatarUrl)
            }
            
        }.resume()
    }
   
}

