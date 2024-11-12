//
//  SignUpProvider.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import SwiftUI
import Alamofire

class SignUpProvider: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
    
    func signUp(id: String, password: String) {
        guard let appURL = Bundle.main.object(forInfoDictionaryKey: "APP_URL"),
              let signUpURI = Bundle.main.object(forInfoDictionaryKey: "SIGN_UP_ROUTER")
        else { return }
        
        let endPoint = "https://\(appURL)/\(signUpURI)"
        
        let params = [
            "userName": id,
            "password": password
        ]
        
        AF.request(endPoint, method: .post, parameters: params).responseDecodable(of: SignUpResult.self) { response in
            switch response.result {
            case .success(let signUpResult):
                print(signUpResult)
                print(id, password)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//#Preview {
//    SignUpProvider()
//}
