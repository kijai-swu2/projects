//
//  SaleDetailViewController.swift
//  Yangpa-market
//
//  Created by 서희재 on 11/7/24.
//

import UIKit

class SaleDetailViewController: UIViewController {
    var sale: Sale?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
        
        // Do any additional setup after loading the view.
    }
    
    func loadDetails() {
        let image = view.viewWithTag(1) as? UIImageView
        let lblProdName = view.viewWithTag(2) as? UILabel
        let lblUserName = view.viewWithTag(3) as? UILabel
        let lblPrice = view.viewWithTag(4) as? UILabel
        let lblCreatedAt = view.viewWithTag(5) as? UILabel
    }
}
