//
//  AddSaleViewController.swift
//  Yangpa-market
//
//  Created by 서희재 on 11/6/24.
//

import UIKit
import PhotosUI
import Alamofire

class AddSaleViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtDesc: UITextField!
    
    
    var camera = UIImagePickerController()
    var picker: PHPickerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* 카메라 인스턴싱 */
        camera.sourceType = .camera
        camera.delegate = self
        
        /* 갤러리 인스턴싱 - PHPickerView는 config를 요구함 */
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        picker = PHPickerViewController(configuration: config)
        picker?.delegate = self
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        let alert = UIAlertController(title: "사진 추가하기", message: "지금 카메라에서 사진을 찍거나 갤러리에 있는 사진을 선택하세요.", preferredStyle: .actionSheet)
        
        let openCamera = UIAlertAction(title: "카메라", style: .default) { _ in
            self.present(self.camera, animated: true)
        }
        let openGallery = UIAlertAction(title: "갤러리", style: .default) { _ in
            self.present(self.picker!, animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(openCamera)
        alert.addAction(openGallery)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @IBAction func submitSale(_ sender: Any) {
        guard let host = Bundle.main.object(forInfoDictionaryKey: "HOST") as? String else { return }
        let endPoint = "https://\(host)/sales"
        
        /* MARK: Form 처리하기 */
        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.8) else { return }
        let formData = MultipartFormData()
        formData.append(imageData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
        formData.append(txtName.text!.data(using: .utf8)!, withName: "productName")
        formData.append(txtPrice.text!.data(using: .utf8)!, withName: "price")
        formData.append(txtDesc.text!.data(using: .utf8)!, withName: "description")
        
        // UserDefaults에서 가져올 종류들이 1개 이상이라면 변수로 선언해 돌려쓰기
        let userDefaults = UserDefaults.standard
        let userName = userDefaults.string(forKey: "userName")
        formData.append(userName!.data(using: .utf8)!, withName: "userName")
        guard let token = userDefaults.string(forKey: "token") else { return } // 토큰이 없을 시 상품을 등록이 거절되므로 guard 방식의 let unwrapping 필수
        
        /* MARK: Request 생성 및 전송하기 */
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "multipart/form-data"
        ]
        AF.upload(multipartFormData: formData, to: endPoint, headers: headers).responseDecodable(of: SalesResult.self) { response in
            print(response)
            switch response.result {
            case .success(let salesResult):
                let alert = UIAlertController(title: "상품 등록", message: salesResult.message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(action)
                self.present(alert, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension AddSaleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            // 바로 사진을 찍어서 사용하는 거라 메인 thread에서 작동함 -> Queue 변경 불필요
            imageView.image = image
            dismiss(animated: true)
        }
    }
}

extension AddSaleViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // 선택된 개체가 있고, 이미지 타입일 경우
        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self) // UIImage.self는 타입을 반환
        else { return } // 위의 경우가 아닐 시 종료
        itemProvider.loadObject(ofClass: UIImage.self) { result, error in
            if let image = result as? UIImage {
                DispatchQueue.main.async{
                    self.imageView.image = image
                }
            }
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
