//
//  AddSale.swift
//  YangpaMarket-1
//
//  Created by Heejae Seo on 11/13/24.
//

import SwiftUI

struct AddSale: View {
    @StateObject var saleCreationProvider = SaleCreationProvider()
    @EnvironmentObject var loginStatus: LoginStatus
    @State var productName = "캠핑체어"
    @State var productPrice = "50000"
    @State var productDesc = "한 번도 안쓴 새 상품이에요. 많은 연락 주세요. 한 번도 안쓴 새 상품이에요. 많은 연락 주세요."
    @State var showPhotoModal: Bool = false
    @State var productPhoto: UIImage?
    
    var body: some View {
        ScrollView {
            Text("상품 등록")
                .font(.title3)
                .padding()
            VStack(alignment: .leading) {
                Text("상품명")
                TextField("상품명을 입력하세요", text: $productName)
                    .padding()
                    .background(Color.textfield)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                    .autocapitalization(.none)
            }
            .padding(.bottom)
            VStack(alignment: .leading) {
                Text("상품 가격")
                TextField("상품 가격을 입력하세요", text: $productPrice)
                    .padding()
                    .background(Color.textfield)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                    .autocapitalization(.none)
            }
            .padding(.bottom)
            VStack(alignment: .leading) {
                Text("상품 설명")
                TextField("상품 설명을 입력하세요", text: $productDesc, axis: .vertical)
                    .padding()
                    .background(Color.textfield)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                    .autocapitalization(.none)
                    .lineLimit(5, reservesSpace: true)
            }
            .padding(.bottom)
            VStack(alignment: .leading) {
                HStack {
                    Text("상품 이미지")
                    Spacer()
                    Button("이미지 추가") {
                        showPhotoModal.toggle()
                    }.sheet(isPresented: $showPhotoModal) {
                        ImageProvider(image: $productPhoto)
                    }
                }
                if let productPhoto {
                    Image(uiImage: productPhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, minHeight: 250)
                        .background(Color.textfield)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                } else {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, minHeight: 250)
                        .foregroundStyle(Color(red: 0, green: 0, blue: 0, opacity: 0.05))
                        .background(Color.textfield)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                }
            }
            .padding(.bottom)
            Button("상품 등록하기") {
                let userName = loginStatus.userName
                print("Hi")
                saleCreationProvider.createSale(productName: productName, description: productDesc, price: productPrice, userName: userName, photo: "abc.jpg")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
        }
        .padding(.horizontal)
        Spacer()
    }
}

#Preview {
    AddSale()
        .environmentObject(LoginStatus())
}
