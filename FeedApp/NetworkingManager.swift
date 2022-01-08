//
//  NetworkingManager.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 13.12.2021.
//

import Foundation

struct Model: Codable {
    var kind: String
    var data: DataModel
}
struct DataModel:Codable {
    var dist: Int
}
class NetworkingManager {
    private init() {
        
    }
    public static let shared = NetworkingManager()
    private let authData = (username: "-",
                            password: "-",
                            client_ID: "eC-5ac7ZHGUS2uGFGQGHQQ")
    private var token: String?
    func getHotNews() {
        guard let url = URL(string: "https://www.reddit.com/r/popular.json?limit=1") else {
            print("URL not found")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard error == nil else{
                print(error)
                return
            }
            guard let data = data else {
                print("No data")
                return
            }
            DispatchQueue.main.async {
                let model = try! JSONDecoder().decode(Model.self, from: data)
                print(model.kind)
            }
            
        }.resume()
    }
    func authenticate() {
        guard let url = URL(string: "https://www.reddit.com/api/v1/access_token") else {
            print("Error fetching url")
            return
        }
        let parametersDictionary = ["grant_type": "password",
                                    "username": authData.username,
                                    "password": authData.password]
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parametersDictionary, options: [])
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) { data, responce, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print("Error data fetch. Responce: ", responce!)
                return
            }
            self.token = Data(data).base64EncodedString()
            print(self.token)
        }.resume()
    }
}

