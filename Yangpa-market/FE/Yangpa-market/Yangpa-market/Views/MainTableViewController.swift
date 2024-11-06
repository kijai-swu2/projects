//
//  MainTableViewController.swift
//  Yangpa-market
//
//  Created by 서희재 on 11/6/24.
//

import UIKit
import Alamofire

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // isLoggedIn이 false이거나 값 자체가 없을 때 로그인 페이지를 표기
        if !UserDefaults.standard.bool(forKey: "isLoggedIn") { // 해당 키의 값이 없을 경우 false, 반대일 경우 true를 반환
            if let loginVC = storyboard?.instantiateViewController(withIdentifier: "login") as? LoginViewController {
                loginVC.modalPresentationStyle = .fullScreen
                present(loginVC, animated: true)
            }
        } else {
            loadList()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sale", for: indexPath)
        
        

        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadList() {
    let endPoint = "\(host)/sales"
                guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        let headers: HTTPHeaders = [ "Authorization": "\(token)" ]
        AF.request(endPoint, headers: headers).responseDecodable(of: SalesResult.self) { response in
//        AF.request(endPoint).responseDecodable(of: SalesResult.self) { response in
            
            if let data = response.data {
                let dataString = String(data: data, encoding: .utf8) ?? "Data could not be printed"
                print("Response Data as String:", dataString)
            }
            
            print(token)
            switch response.result {
            case .success(let salesResult):
                print(salesResult.documents)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
