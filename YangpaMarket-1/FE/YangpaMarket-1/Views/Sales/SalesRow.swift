//
//  SalesRow.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import SwiftUI
import Foundation

let sampleSale = Sale(id: 1, productName: "캠핑 의자", description: "한 번만 사용했어요", price: 50000, photo: "paris1730862427831.jpg", userName: "admin", createdAt: "2024-11-06T03:07:07.960Z", photoURL: URL(string: "https://sayangpakitcat.blob.core.windows.net/yangpa/paris1730862427831.jpg"))

struct SalesRow: View {
    let sale: Sale
    
    var body: some View {
        HStack {
            AsyncImage(url: sale.photoURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .background(Color.gray)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 40)
                    .foregroundStyle(Color.gray)
            }
            .padding(.trailing, 5)
            VStack {
                HStack {
                    Text(sale.productName)
                        .font(.headline)
                    Spacer()
                    Text(sale.createdAt)
                        .foregroundStyle(Color.gray)
                }
                .padding(.bottom, 5)
                HStack {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .foregroundStyle(Color.gray)
                        Text(sale.userName)
                    }
                    Spacer()
                    Text("\(sale.price)원")
                        .foregroundStyle(Color.blue)
                }
            }
        }
    }
}

#Preview {
    SalesRow(sale: sampleSale)
}
