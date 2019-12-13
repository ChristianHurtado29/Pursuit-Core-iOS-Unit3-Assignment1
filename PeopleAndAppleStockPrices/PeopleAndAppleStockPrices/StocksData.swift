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
