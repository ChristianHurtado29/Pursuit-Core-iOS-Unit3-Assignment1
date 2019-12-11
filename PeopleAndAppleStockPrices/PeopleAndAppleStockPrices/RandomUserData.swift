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
    var fullName: String { return name.first + " " + name.last }
    let email: String
    let picture: Pic
}

struct Name: Decodable {
    let title, first, last: String
}

struct Location: Decodable {
    let city, country: String
}

struct Pic: Decodable {
    let large, medium, thumbnail: String
}


extension RandomUserData {
static func getUsers() -> [User] {
    var users = [User]()
    do {
        let data = Bundle.parseJSONData(filename: "RandomUKUser", ext: "json")
        let randomUserData = try JSONDecoder().decode(RandomUserData.self, from: data)
        users = randomUserData.results.sorted {$0.name.last < $1.name.last}
    } catch {
        fatalError("\(error)")
    }
    return users
}
}
