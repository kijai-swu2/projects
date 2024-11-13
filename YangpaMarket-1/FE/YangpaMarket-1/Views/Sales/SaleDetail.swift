//
//  SaleDetail.swift
//  YangpaMarket-1
//
//  Created by Heejae Seo on 11/13/24.
//

import SwiftUI

struct SaleDetail: View {
    @StateObject var saleProvider = SalesProvider()
    var saleID: Int
    
    var body: some View {
        
        ScrollView {
            Text("상품 상세")
                .font(.title3)
                .padding()
            if let sale = saleProvider.sale {
                VStack {
                    Text(sale.productName)
                        .font(.headline)
                        .padding(.bottom)
                    Text("\(sale.price)원")
                        .padding(.bottom)
                        .foregroundStyle(Color.blue)
                    VStack(alignment: .leading) {
                        Text("상품 설명")
                            .font(.subheadline)
                        Text(sale.description)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            saleProvider.getSale(saleID: saleID)
        }
    }
    
}

#Preview {
    SaleDetail(saleID: sampleSale.id)
}
