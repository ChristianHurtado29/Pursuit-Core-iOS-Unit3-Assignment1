//
//  UIImageView+Extensions.swift
//  AstronomyPhotos
//
//  Created by Christian Hurtado on 12/9/19.
//  Copyright © 2019 Christian Hurtado. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // instance method
    func setImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        
        // configure UIActivityIndicatorView
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .orange
        activityIndicator.center = center // implies center of the UIImageView
        addSubview(activityIndicator) // this adds the UIActivityIndicatorView to the ImageView
        activityIndicator.startAnimating()
        
        NetworkHelper.shared.performDataTask(with: urlString) { [weak activityIndicator](result) in
            
            DispatchQueue.main.async {
                activityIndicator?.stopAnimating()
            }
            
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
        }
    }
}
