//
//  StockVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by Christian Hurtado on 12/9/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StockVC: UIViewController {

    @IBOutlet weak var stockTableView: UITableView!
    
    @IBOutlet weak var stockSearchBar: UISearchBar!
    
    var stock = [Stocks]() {
        didSet{
            stockTableView.reloadData()
        }
    }
    
    var appSect = [[Stocks]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        loadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailStockVC = segue.destination as? DetailStockVC,
            let indexPath = stockTableView.indexPathForSelectedRow else {
                fatalError("messed up segue")
        }
        detailStockVC.stock = stock[indexPath.row]
    }
    
    func loadData() {
        stock = Stocks.getStocks()
        let sortedStock = stock.sorted{ $0.date < $1.date }
    
        var dateArr = [String]()
        
        let setDate: Set<String> = Set(sortedStock.map { $0.date })
        
        for cas in setDate {
            var andra = cas.components(separatedBy: "-")
            andra.removeLast()
            dateArr.append(andra.joined(separator: " "))
        }
        
        let setAct = Set(dateArr)
        let shit = Array(setAct).sorted()
        
        appSect = Array(repeating: [Stocks](), count: setAct.count)
        
        var currentIndex = 0
        var sectIndex = 0
        var currentSect = shit[sectIndex]
        
        for anon in sortedStock {
            var ymous = anon.date.components(separatedBy: "-")
            ymous.removeLast()
            let yearMonth = ymous.joined(separator: " ")
            
            if yearMonth == currentSect {
                appSect[currentIndex].append(anon)
            } else {
                currentIndex += 1
                sectIndex += 1
                currentSect = shit[sectIndex]
                appSect[currentIndex].append(anon)
            }
        }

    }

}

extension StockVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appSect[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return appSect.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let titleArr = appSect[section].first?.label.components(separatedBy: " ") else {
        return ""
    }
        let thanksCas = "\(titleArr[0]), \(titleArr[2])"
        
        return thanksCas
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let selStock = appSect[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = selStock.date
        cell.detailTextLabel?.text = selStock.label
        
        return cell
    }
}
