//
//  ImageAPIClient+Extension.swift
//  Unit3-PersonalProject-Fortnite
//
//  Created by Liubov Kaper  on 1/5/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

extension UIImageView {
  func getImage(with urlString: String,
                completion: @escaping (Result<UIImage, AppError>) -> ()) {
    
    
    // this part changes http to https
   // let urlString = "https" + urlString.dropFirst(4)
    // The UIActivityIndicatorView is used to indicate to the user that a download is in progress
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .orange
    activityIndicator.startAnimating() // it's hidden until we explicitly start animating
    activityIndicator.center = center
    addSubview(activityIndicator) // we add the indicattor as a subview of the image view
    
    guard let url = URL(string: urlString) else {
      completion(.failure(.badURL(urlString)))
        
      return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { [weak activityIndicator] (result) in
      DispatchQueue.main.async {
        activityIndicator?.stopAnimating() // hides when we stop animating the indicator
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
