//
//  Bundle + Ext.swift
//  PeopleAndAppleStockPrices
//
//  Created by Christian Hurtado on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

extension Bundle {
    static func parseJSONData(filename: String, ext: String) -> Data {
        
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext) else {
            fatalError("error")
        }
        var data: Data!
        do {
            data = try Data.init(contentsOf: fileURL)
        } catch {
            fatalError("\(error)")
        }
        return data
    }
}
