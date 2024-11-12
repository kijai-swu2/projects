//
//  SalesList.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import SwiftUI

struct SalesList: View {
    @StateObject var salesProvider = SalesProvider()
    
    var body: some View {
        HStack {
            List(salesProvider.sales) { sale in
                SalesRow(sale: sale)
            }
            .listStyle(.plain)
            .onAppear {
                salesProvider.getSales()
            }
            
        }
    }
}

#Preview {
    SalesList()
}
