//
//  ImageViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 北舘友頼 on 2023/03/31.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

class ImageViewModel {
    func getImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        Task.init {
            if let data = await searchFromUrl(searchType: .image, keyWord:urlString) {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
    }
}
