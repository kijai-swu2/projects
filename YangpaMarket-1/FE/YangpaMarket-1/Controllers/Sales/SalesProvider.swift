//
//  SalesProvider.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import SwiftUI
import Alamofire

class SalesProvider: ObservableObject {
    @Published var sales: [Sale] = []
    @Published var saleID: Int = 0
    @Published var sale: Sale?
    
    func getSales() {
        guard let token = UserDefaults.standard.string(forKey: "token"),
              let appURL = Bundle.main.object(forInfoDictionaryKey: "APP_URL"),
              let saURL = Bundle.main.object(forInfoDictionaryKey: "SA_URL"),
              let salesURI = Bundle.main.object(forInfoDictionaryKey: "SALES_ROUTER")
        else { return }
        
        let endPoint = "https://\(appURL)\(salesURI)"
        
        let headers: HTTPHeaders = [ "Authorization": "Bearer \(token)" ]
        
        AF.request(endPoint, method: .get, headers: headers).responseDecodable(of: SalesResult.self) { response in
            switch response.result {
            case .success(let salesResult):
                self.sales = salesResult.documents
                self.sales[0].photoURL = URL(string: "https://\(saURL)/\(salesResult.documents[0].photo)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getSale(saleID: Int) {
        guard let token = UserDefaults.standard.string(forKey: "token"),
              let appURL = Bundle.main.object(forInfoDictionaryKey: "APP_URL"),
//              let saURL = Bundle.main.object(forInfoDictionaryKey: "SA_URL"),
              let salesURI = Bundle.main.object(forInfoDictionaryKey: "SALES_ROUTER")
                //              let saleID
        else { return }
        
        let endPoint = "https://\(appURL)\(salesURI)/\(saleID)"
        
        let headers: HTTPHeaders = [ "Authorization": "Bearer \(token)" ]
        
        AF.request(endPoint, method: .get, headers: headers).responseDecodable(of: SalesResult.self) { response in
            print(response)
            switch response.result {
            case .success(let salesResult):
                if salesResult.documents.count >= 1 {
                    self.sale = salesResult.documents[0]
                    print(self.sale!)
                } else {
                    print("데이터 없음")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//#Preview {
//    SalesProvider()
//}
