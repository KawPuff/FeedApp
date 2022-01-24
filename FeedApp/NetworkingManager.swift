//
//  NetworkingManager.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 13.12.2021.
//

import Foundation

protocol RedditMangerProtocol{
    
    static var shared: RedditMangerProtocol { get }
    
    func getPosts(subreddit: String, limit: Int, _ completion: @escaping (Result<ContentModel>) -> Void)
    
}
class RedditManager: RedditMangerProtocol {
    
    private init() {
        
    }
    public static var shared: RedditMangerProtocol = RedditManager()
    
    func getPosts(subreddit: String, limit: Int, _ completion: @escaping (Result<ContentModel>) -> Void) {
        guard let url = URL(string: "https://www.reddit.com/r/" + subreddit +
                                    ".json?limit=" + String(limit) +
                                    "")
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
            
            guard let parsedData = try? JSONDecoder().decode(SomeModel.self, from: data) else {
                completion(.failure("Error parsing data"))
                return
            }
            DispatchQueue.main.async {
                completion(.success(parsedData))
            }
            
        }.resume()
    }
    
   
}

