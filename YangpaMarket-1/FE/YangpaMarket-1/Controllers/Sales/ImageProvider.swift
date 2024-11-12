//
//  ImageProvider.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/13/24.
//

import SwiftUI
import UIKit
import PhotosUI

/* ImageView 생성하기 */
struct ImageProvider: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(parent: self)
    }
}

/* Coordinator 설정 : UIKit Delegate의 역할 */
class ImagePickerCoordinator: NSObject, PHPickerViewControllerDelegate {
    let parent: ImageProvider
    init(parent: ImageProvider) {
        self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        guard let itemProvider = results.first?.itemProvider
        else { return }
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                self.parent.image = image as? UIImage
            }
        }
        picker.dismiss(animated: true)
    }
}
