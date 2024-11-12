//
//  SaleCreationProvider.swift
//  YangpaMarket-1
//
//  Created by Heejae Seo on 11/13/24.
//

import SwiftUI
import Alamofire

class SaleCreationProvider: ObservableObject {
    @Published var sale: Sale?
    
//    func uploadImage(
    
    func createSale(productName: String, description: String, price: String, userName: String, photo: String) {
        guard let token = UserDefaults.standard.string(forKey: "token"),
              let appURL = Bundle.main.object(forInfoDictionaryKey: "APP_URL"),
              let saURL = Bundle.main.object(forInfoDictionaryKey: "SA_URL"),
              let salesURI = Bundle.main.object(forInfoDictionaryKey: "SALES_ROUTER")
        else { return }
        
        let endPoint = "https://\(appURL)\(salesURI)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "multipart/form-data",
        ]
        
        let formData = MultipartFormData()
        formData.append(productName.data(using: .utf8)!, withName: "productName")
        formData.append(description.data(using: .utf8)!, withName: "description")
        formData.append(price.data(using: .utf8)!, withName: "price")
        formData.append(userName.data(using: .utf8)!, withName: "userName")
        formData.append(photo.data(using: .utf8)!, withName: "photo")
        
        AF.upload(multipartFormData: formData, to: endPoint, method: .put, headers: headers).responseDecodable(of: SalesResult.self) { response in
            print(response)
            switch response.result {
            case .success(let salesResult):
                print(salesResult)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
