//
//  LoadOperation.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 08.06.2022.
//

import UIKit

final class LoadOperation: Operation {
    
    var image: UIImage?
    
    var callback: ((UIImage?) -> Void)?
    private var loadURL: URL
    
    init(url: URL) {
        self.loadURL = url
        super.init()
    }
    
    override func main() {
        URLSession.shared.dataTask(with: loadURL) { [weak self] data, _ , error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            DispatchQueue.main.async  { [weak self] in
                guard let self = self else { return }
                if self.isCancelled { return }
                guard let data = data else { return }
                guard let image = UIImage(data: data) else {
                    print("Fetched data isn't image")
                    return
                }
                self.image = image
                self.callback?(image)
            }
        }.resume()
    }
}
