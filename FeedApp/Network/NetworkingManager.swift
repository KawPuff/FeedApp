//
//  NetworkingManager.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 13.12.2021.
//

import Foundation

protocol RedditMangerProtocol{
    
    static var shared: RedditMangerProtocol { get }
    
    func getPosts(subreddit: String, limit: Int, _ completion: @escaping (Result<Listing>) -> Void)
    
}
class RedditManager: RedditMangerProtocol {
    
    private init() {
        
    }
    public static var shared: RedditMangerProtocol = RedditManager()
    
    func getPosts(subreddit: String, limit: Int, _ completion: @escaping (Result<Listing>) -> Void) {
        guard let url = URL(string: "https://www.reddit.com/r/popular.json")
        else {
            completion(.failure("Url not found"))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _ , error in
            guard error == nil else {
                completion(.failure(error!.localizedDescription))
                return
            }
            guard let data = data else {
                completion(.failure("No data found"))
                return
            }
            guard let object = try? JSONSerialization.jsonObject(with: data, options: []) else {
                print("Error creating jsonObject")
                return
            }
            guard let jsonDictionary = object as? JSONDictionary, let listingJson = jsonDictionary["data"] as? JSONDictionary else {
                print("Error creating jsonDictionary")
                return
            }
            
            DispatchQueue.main.async {
                let listing = Listing(json: listingJson)
                completion(.success(listing))
            }
            
        }.resume()
    }
    
   
}

