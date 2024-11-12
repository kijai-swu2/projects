//
//  SaleDetail.swift
//  YangpaMarket-1
//
//  Created by Heejae Seo on 11/13/24.
//

import SwiftUI

struct SaleDetail: View {
    @EnvironmentObject var loginStatus: LoginStatus
    @StateObject var saleProvider = SalesProvider()
    var saleID: Int
    
    var body: some View {
        ScrollView {
            Text("상품 상세")
                .font(.title3)
                .padding()
            VStack {
//                if let sale = saleProvider. {
//                    VStack(alignment: .leading) {
//                        Text("상품명")
//                        Text(sale.productName)
//                            .padding()
//                            .background(Color.textfield)
//                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
//                    }
//                    .padding(.bottom)
//                    VStack(alignment: .leading) {
//                        Text("상품 가격")
//                        Text(sale.productPrice)
//                            .padding()
//                            .background(Color.textfield)
//                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
//                    }
//                    .padding(.bottom)
//                    VStack(alignment: .leading) {
//                        Text("상품 설명")
//                        Text(sale.productDesc)
//                            .padding()
//                            .background(Color.textfield)
//                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
//                    }
//                }
//                    .padding(.horizontal)
                Spacer()
            }
        }
    }
}

#Preview {
    SaleDetail(saleID: 1)
}
