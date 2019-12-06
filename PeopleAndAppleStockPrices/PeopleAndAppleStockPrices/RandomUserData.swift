//
//  RandomUKUserData.swift
//  PeopleAndAppleStockPrices
//
//  Created by Christian Hurtado on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct RandomUserData: Decodable {
    let results: [User]
}

struct User: Decodable {
    let name: Name
    let location: Location
    let email: String
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}

struct Location: Decodable {
    let country: String
    let city: String
}


extension RandomUserData {
static func getUsers() -> [User] {
    var users = [User]()
    do {
        let data = Bundle.parseJSONData(filename: "RandomUKUser", ext: "json")
        let randomUserData = try JSONDecoder().decode(RandomUserData.self, from: data)
        users = randomUserData.results
    } catch {
        fatalError("\(error)")
    }
    return users
}
}
