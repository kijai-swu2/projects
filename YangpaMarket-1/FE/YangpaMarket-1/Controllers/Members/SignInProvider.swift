//
//  SignInProvider.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import SwiftUI
import Alamofire

class SignInProvider: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
    
    func signIn(id: String, password: String, status: LoginStatus) {
        guard let appURL = Bundle.main.object(forInfoDictionaryKey: "APP_URL"),
              let signInURI = Bundle.main.object(forInfoDictionaryKey: "SIGN_IN_ROUTER")
        else { return }
        
        let endPoint = "https://\(appURL)/\(signInURI)"
        
        let params = [
            "userName": id,
            "password": password
        ]
        
        AF.request(endPoint, method: .post, parameters: params).responseDecodable(of: SignInResult.self) { response in
            switch response.result {
            case .success(let signInResult):
                print(signInResult)
                UserDefaults.standard.set(signInResult.token, forKey: "token")
                status.isLoggedIn = true
                status.userName = signInResult.member.userName
                print(signInResult.member.userName)
                print(status.userName)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//#Preview {
//    SignInProvider()
//}
