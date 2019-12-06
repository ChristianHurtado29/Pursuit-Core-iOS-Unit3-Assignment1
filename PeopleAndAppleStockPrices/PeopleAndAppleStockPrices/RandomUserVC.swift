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
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.reloadData()
        tableView.dataSource = self
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
        
        cell.textLabel?.text = "\(selUser.name.title) \(selUser.name.first) \(selUser.name.last)"
        cell.detailTextLabel?.text = "\(selUser.location.city), \(selUser.location.country)"
        
        return cell
    }
}
