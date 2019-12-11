//
//  StocksData.swift
//  PeopleAndAppleStockPrices
//
//  Created by Christian Hurtado on 12/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Stocks:Codable {
    let date: String
    let close: Double
    let open: Double
    let label: String
    let change: Double
}

//static func getMonths() -> [[Stocks]] {
//
//    let sortedMonths = stocks.sorted { $0.label < $1.label }
//  let classificationTitles: Set<String> = Set(zooAnimals.map { $0.classification })
//  var sectionsArr = Array(repeating: [ZooAnimal](), count: classificationTitles.count)
//  var currentIndex = 0
//  var currentClassification = sortedClassifications.first?.classification ?? "Pursuit"
//  for animal in sortedClassifications {
//    if animal.classification == currentClassification {
//      sectionsArr[currentIndex].append(animal)
//    } else {
//      currentIndex += 1
//      currentClassification = animal.classification
//      sectionsArr[currentIndex].append(animal)
//    }
//  }
//  return sectionsArr
//}




extension Stocks {
    static func getStocks() -> [Stocks] {
        var stockInfo = [Stocks]()
        
        guard let fileURL = Bundle.main.url(forResource: "stocks", withExtension: "json") else {
            fatalError("FUCK!!!")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let stockData = try JSONDecoder().decode([Stocks].self, from: data)
            stockInfo = stockData.sorted {$0.date < $1.date}
        } catch {
            fatalError("\(error)")
        }
        return stockInfo
    }
}
