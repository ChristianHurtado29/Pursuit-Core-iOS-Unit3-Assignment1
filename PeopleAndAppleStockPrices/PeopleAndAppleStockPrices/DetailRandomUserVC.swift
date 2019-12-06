//
//  DetailRandomUserVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by Christian Hurtado on 12/6/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailRandomUserVC: UIViewController {
    
    var randomUser: User!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel?.text = "\(randomUser.name.title) \(randomUser.name.first) \(randomUser.name.last)"
        emailLabel?.text = randomUser.email
        
        locationLabel?.text = "\(randomUser.location.city), \(randomUser.location.country)"
        
        
    }
    

}
