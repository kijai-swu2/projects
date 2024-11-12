//
//  MainView.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import SwiftUI

struct MainView: View {
    @State var isLoggedIn = false
    
    var body: some View {
        if isLoggedIn == false {
            LoginView()
        } else {
            SalesList()
        }
    }
}

#Preview {
    MainView()
}
