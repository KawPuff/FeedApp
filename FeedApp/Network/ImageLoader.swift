//
//  ImageLoader.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 09.05.2022.
//

import UIKit

typealias ImageCache = NSCache<AnyObject, AnyObject>

final class ImageLoader {
    
    private var cache: ImageCache = ImageCache()
    
    public static let shared = ImageLoader()
    
    private init() {
        
    }
    
    func load(by url: String, completion: @escaping (UIImage?) -> ()){
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        if let image = getChachedImage(url) {
            completion(image)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data else {
                return
            }
            DispatchQueue.main.async { [unowned self] in
                guard let image = UIImage(data: data) else {
                    print("Fetched data isn't image")
                    return
                }
                setCachedImage(image: image, url: url)
                completion(UIImage(data: data))
            }
        }.resume()
    }
    private func getChachedImage(_ url: URL) -> UIImage? {
        return cache.object(forKey: url as AnyObject) as? UIImage
    }
    private func setCachedImage(image: UIImage, url: URL){
        cache.setObject(image as AnyObject, forKey: url as AnyObject)
    }
}
