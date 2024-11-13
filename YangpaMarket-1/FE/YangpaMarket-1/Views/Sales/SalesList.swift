//
//  SalesList.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import SwiftUI

struct SalesList: View {
    @StateObject var salesProvider = SalesProvider()
    @EnvironmentObject var loginStatus: LoginStatus
    @State var showCreateModal = false
    
    var body: some View {
        NavigationSplitView {
            List(salesProvider.sales) { sale in
                NavigationLink {
                    SaleDetail(saleID: sale.id)
                        .onAppear {
                            print(sale.id)
                        }
                } label: {
                    SalesRow(sale: sale)
                }
            }.onAppear {
                salesProvider.getSales()
            }
            .listStyle(.plain)
            .navigationTitle("상품 목록")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCreateModal.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.blue)
                    }
                }
            }
            .sheet(isPresented: $showCreateModal) {
                AddSale()
            }
        } detail: {
        }
    }
}

#Preview {
    SalesList()
        .environmentObject(LoginStatus())
}
