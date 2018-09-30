//
//  UIImageView+DownloadImage.swift
//  StoreSearch
//
//  Created by imac on 2017/7/20.
//  Copyright © 2017年 songyp. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: url, completionHandler:{
            [weak self] url, response, error in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let strongSelf = self {
                        strongSelf.image = image
                    }
                }
            }
        } )
        downloadTask.resume()
        return downloadTask
    }
}
