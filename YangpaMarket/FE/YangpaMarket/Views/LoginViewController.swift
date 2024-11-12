//
//  LoginViewController.swift
//  Yangpa-market
//
//  Created by 서희재 on 11/6/24.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actSignIn(_ sender: Any) {
        let paramaters: Parameters = [
            "userName": txtId.text!,
            "password": txtPassword.text!
        ]
        
        guard let host = Bundle.main.object(forInfoDictionaryKey: "HOST") as? String else { return }
        let endPoint = "https://\(host)/members/sign-in"
        
        let request = AF.request(endPoint, method: .post, parameters: paramaters)
        request.responseDecodable(of: SignInResult.self) { response in
            switch response.result {
            case .success(let signInResult):
                if signInResult.success { // signInResult 모델의 success 값이 true라면
                    UserDefaults.standard.set(signInResult.token, forKey: "token")
                    UserDefaults.standard.set(signInResult.member.userName, forKey: "userName")
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    self.dismiss(animated: true) // 성공 시 모달 가리기
                } else {
                    let alert = UIAlertController(title: "로그인 실패", message: signInResult.message, preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func actSignUp(_ sender: Any) {
        let paramaters: Parameters = [
            "userName": txtId.text!,
            "password": txtPassword.text!
        ]
        guard let host = Bundle.main.object(forInfoDictionaryKey: "HOST") else { return }
        let endPoint = "\(host)/members/sign-up"
        
        let request = AF.request(endPoint, method: .post, parameters: paramaters)
        request.responseDecodable(of: SignUpResult.self) { response in
            switch response.result {
            case .success(let signUpResult):
                let alert = UIAlertController(title: "회원가입", message: signUpResult.message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default) { _ in
                    self.txtId.text = ""
                    self.txtPassword.text = ""
                }
                alert.addAction(action)
                self.present(alert, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
