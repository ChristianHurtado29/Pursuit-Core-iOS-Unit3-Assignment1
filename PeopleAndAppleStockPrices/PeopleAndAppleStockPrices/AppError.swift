//
//  AppError.swift
//  AstronomyPhotos
//
//  Created by Christian Hurtado on 12/9/19.
//  Copyright © 2019 Christian Hurtado. All rights reserved.
//

import Foundation

// Error Handling against network requests
// some errors could be network connection lost

enum AppError: Error {
    case badURL(String) // associated value - to capture values around the error
    case noResponse
    case networkClientError(Error)
    case noData
    case decodingError(Error)
    case badStatusCode(Int) // 404/500/etc
    case badMimeType(String) // image/jpg
}
