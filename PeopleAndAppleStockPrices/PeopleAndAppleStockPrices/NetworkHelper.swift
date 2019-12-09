//
//  NetworkHelper.swift
//  AstronomyPhotos
//
//  Created by Christian Hurtado on 12/9/19.
//  Copyright © 2019 Christian Hurtado. All rights reserved.
//

import Foundation

class NetworkHelper {
    
    // we will create shared instance of the NetworkHelper
    // THIS IS THE ONLY PLACE WHERE THE INSTANCE IS CREATED!
    static let shared = NetworkHelper()
    
    private var session: URLSession
    
    // we will make the default initializer private
    // required in order to be considered a singleton
    // also forbids anyone from creating an instance of NetworkHelper
    private init() {
        session = URLSession(configuration: .default)
    }
    
    func performDataTask(with urlString: String,
                         completion: @escaping (Result<Data, AppError>) -> ()) {
        
        // creating a URL from the given String
        guard let url = URL(string: urlString) else {
            // handle bard url error case
            completion(.failure(.badURL(urlString)))
            return
        }
        
        // two states on dataTask, resume() and suspended by default
        // suspended simply won't perform netork errors and time list if you don't explicitly resume() request
        
        let dataTask = session.dataTask(with: url) {(data, response, error) in
            
            // 1. deal with error if any
            // check for client network errors
            if let error = error {
                completion(.failure(.networkClientError(error)))
            }
            
            // 2. downcast URLResponse (response) to HTTPURLResponse to get access to the statusCode
            //    property to HTTPURLResponse.
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            // 3. unwrap the data object.
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // 4. validate that the status code is in the 200 range
            //    otherwise it's a bad status code.
            switch urlResponse.statusCode {
            case 200...299: break
            default:
                completion(.failure(.badStatusCode(urlResponse.statusCode)))
            }
            
            // 5. capture data as success
            completion(.success(data))
        }
        dataTask.resume()
    }
    
}
