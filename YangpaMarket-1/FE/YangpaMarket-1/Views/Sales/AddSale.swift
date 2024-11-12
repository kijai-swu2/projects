//
//  AddSale.swift
//  YangpaMarket-1
//
//  Created by Heejae Seo on 11/13/24.
//

import SwiftUI

struct AddSale: View {
    @State var productName = "캠핑체어"
    @State var productPrice = "50000"
    @State var productDesc = "한 번도 안쓴 새 상품이에요. 많은 연락 주세요. 한 번도 안쓴 새 상품이에요. 많은 연락 주세요."
    
    var body: some View {
        VStack {
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
            Button {
                SaleCreationProvider()
            } label: {
                <#code#>
            }

        }
        .padding(.horizontal)
    }
}

#Preview {
    AddSale()
}
