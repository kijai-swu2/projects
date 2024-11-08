//
//  MainTableViewController.swift
//  Yangpa-market
//
//  Created by 서희재 on 11/6/24.
//

import UIKit
import Alamofire
import Kingfisher

class MainTableViewController: UITableViewController {
    var sales: [Sale]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        
        // isLoggedIn이 false이거나 값 자체가 없을 때 로그인 페이지를 표기
        if !UserDefaults.standard.bool(forKey: "isLoggedIn") { // 해당 키의 값이 없을 경우 false, 반대일 경우 true를 반환
            if let loginVC = storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController {
                loginVC.modalPresentationStyle = .fullScreen
                present(loginVC, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let host = Bundle.main.object(forInfoDictionaryKey: "HOST") as? String,
              let token = UserDefaults.standard.string(forKey: "token")
        else { return }
        let endPoint = "https://\(host)/sales"
        
        let headers: HTTPHeaders = [ "Authorization": "Bearer \(token)" ]
        
        AF.request(endPoint, headers: headers).responseDecodable(of: SalesResult.self) { response in
            switch response.result {
            case .success(let salesResult):
                self.sales = salesResult.documents
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sales?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sale", for: indexPath)
        
        guard let sale = sales?[indexPath.row],
              let strURL = Bundle.main.object(forInfoDictionaryKey: "STR_URL")
        else { return cell }
        
        let image = cell.viewWithTag(1) as? UIImageView
        let strImageURL = "https://\(strURL)/\(sale.photo)"
        let imageURL = URL(string: strImageURL)
        image?.kf.setImage(with: imageURL)
        
        let txtName = cell.viewWithTag(2) as? UILabel
        txtName?.text = sale.productName
        
        let txtPrice = cell.viewWithTag(3) as? UILabel
        txtPrice?.text = "\(String(sale.price))원"
        
        let txtUserName = cell.viewWithTag(4) as? UILabel
        txtUserName?.text = sale.userName
        
        let txtCreatedAt = cell.viewWithTag(5) as? UILabel
        txtCreatedAt?.text = String(sale.createdAt.prefix(10))
        
        return cell
    }
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let detailVC = segue.destination as? SaleDetailViewController,
               let selectedRow = tableView.indexPathForSelectedRow
         else { return }
         
         detailVC.saleID = sales![selectedRow.row].id
         print(detailVC)
     }
    
}
