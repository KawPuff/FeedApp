//
//  NetworkingManager.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 13.12.2021.
//

import Foundation

protocol NetworkManager {
    
    static var shared: NetworkManager { get }
    
    func getPosts(subreddit: String, limit: Int, after itemName: String?,_ completion: @escaping (Result<Listing>) -> Void)
    
}
class RedditManager: NetworkManager {
    
    private init() {
        
    }
    
    public static var shared: NetworkManager = RedditManager()
    
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
    
   
}

