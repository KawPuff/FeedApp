//
//  ImageLoader.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 09.05.2022.
//

import UIKit

typealias ImageCache = NSCache<AnyObject, AnyObject>

final class ImageLoader {
    
    public static let shared = ImageLoader()
    
    private var cache: ImageCache = ImageCache()
    
    private let loadingQueue: OperationQueue = {
        let loadingQueue = OperationQueue()
        loadingQueue.maxConcurrentOperationCount = 10
        return loadingQueue
    }()
    
    private var loadingOperations: Dictionary<URL,LoadOperation> = [:]
    
    private init() {
        
    }
    
    func cancelLoad(by url: String) {
        guard let url = URL(string: url) else {
            return
        }
        if let operation = loadingOperations[url] {
            operation.cancel()
            loadingOperations.removeValue(forKey: url)
        }
    }
    
    func load(by url: String, completion:  ((UIImage?) -> ())?){
        guard let url = URL(string: url) else {
            completion?(nil)
            return
        }
        
        if let image = getChachedImage(url) {
            completion?(image)
            return
        }
        
        if let operation = loadingOperations[url] {
            if let image = operation.image {
                setCachedImage(image: image, url: url)
                loadingOperations.removeValue(forKey: url)
                completion?(image)
                return
            }
            operation.callback = { [unowned self] image in
                guard let image = image else {
                    return
                }
                self.setCachedImage(image: image, url: url)
                loadingOperations.removeValue(forKey: url)
                completion?(image)
            }
            return
        }
        let operation = LoadOperation(url: url)
        operation.callback = { [unowned self] image in
            guard let image = image else {
                return
            }
            self.setCachedImage(image: image, url: url)
            loadingOperations.removeValue(forKey: url)
            completion?(image)
        }
        loadingOperations[url] = operation
        loadingQueue.addOperation(operation)
    }
    
    private func getChachedImage(_ url: URL) -> UIImage? {
        return cache.object(forKey: url as AnyObject) as? UIImage
    }
    private func setCachedImage(image: UIImage, url: URL){
        cache.setObject(image as AnyObject, forKey: url as AnyObject)
    }
    
}
