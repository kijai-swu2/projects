//
//  SaleDetailViewController.swift
//  Yangpa-market
//
//  Created by 서희재 on 11/7/24.
//

import UIKit
import Alamofire

class SaleDetailViewController: UIViewController {
    var saleID: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
    }
    
    func loadDetails() {
        guard let host = Bundle.main.object(forInfoDictionaryKey: "HOST") as? String,
              let token = UserDefaults.standard.string(forKey: "token"),
              let strURL = Bundle.main.object(forInfoDictionaryKey: "STR_URL") as? String,
              let saleID
        else { return }
        
        let image = view.viewWithTag(1) as? UIImageView
        let lblProdName = view.viewWithTag(2) as? UILabel
        let lblUserName = view.viewWithTag(3) as? UILabel
        let lblPrice = view.viewWithTag(4) as? UILabel
        let lblCreatedAt = view.viewWithTag(5) as? UILabel
        
        let endpoint = "https://\(host)/sales/\(saleID)"
        let headers: HTTPHeaders = [ "Authorization": "Bearer \(token)" ]
        AF.request(endpoint, method: .get, headers: headers).responseDecodable(of: SalesResult.self) { response in
            switch response.result {
            case .success(let sales):
                print(sales)
//                DispatchQueue.main.async {
//                    lblProdName.text = sales
//                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
