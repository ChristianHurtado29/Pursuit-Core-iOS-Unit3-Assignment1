//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class RandomUserVC: UIViewController {
    
    var user = RandomUserData.getUsers(){
        didSet{
            tableView.reloadData()
        }
    }
    
    var searchQuery = ""{
        didSet{
            searchBarQuery()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.reloadData()
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func loadData() {
        tableView.reloadData()
    }
    
    func searchBarQuery() {
        user = RandomUserData.getUsers().filter{$0.fullName.contains(searchQuery.lowercased())}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailRandomUserVC = segue.destination as? DetailRandomUserVC,
        let indexPath = tableView.indexPathForSelectedRow else{
        fatalError("Failed to get indexPath and detailViewController!")
    }
        detailRandomUserVC.randomUser = user[indexPath.row]
}
}

extension RandomUserVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let selUser = user[indexPath.row]
        
        cell.textLabel?.text = "\(selUser.name.title). \(selUser.name.first) \(selUser.name.last)"
        cell.detailTextLabel?.text = "\(selUser.location.city), \(selUser.location.country)"
        
        return cell
    }
}

extension RandomUserVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchBarQuery()
            loadData()
            return
        }
        searchQuery = searchText
    }
}
