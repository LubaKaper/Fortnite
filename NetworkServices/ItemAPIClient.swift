//
//  ItemAPIClient.swift
//  Unit3-PersonalProject-Fortnite
//
//  Created by Liubov Kaper  on 1/5/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation

struct ItemAPIClient {
    
    static func fetchItem (completion: @escaping (Result<[Item], AppError>) ->()) {
        let itemURLString = "https://api.fortnitetracker.com/v1/store"
        
        guard let url = URL(string: itemURLString) else {
            completion(.failure(.badURL(itemURLString)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("6240352d-887a-45ae-b0ea-8388ed5df3d4", forHTTPHeaderField: "TRN-Api-Key")
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode([Item].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
