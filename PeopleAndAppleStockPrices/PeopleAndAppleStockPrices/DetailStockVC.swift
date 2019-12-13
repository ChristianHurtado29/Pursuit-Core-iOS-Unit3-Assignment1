//
//  DetailStockVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by Christian Hurtado on 12/13/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailStockVC: UIViewController {
    
    
    var stock: Stocks?
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var dateImage: UIImageView!
    
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var closeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = stock?.label
        openLabel.text = "Opened at: $\(stock!.open.description)"
        closeLabel.text = "Closed at: $\(stock!.close.description)"
        thumbs()
        
    }
    
    func thumbs() {
        
        if stock!.change >= 0.0 {
            view.backgroundColor = .green
            dateImage.image = #imageLiteral(resourceName: "thumbsUp")
        } else {
            view.backgroundColor = .red
            dateImage.image = #imageLiteral(resourceName: "thumbsDown")
        }
    }
    
    
    
    
}
