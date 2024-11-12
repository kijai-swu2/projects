//
//  MainView.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var signInProvider = SignInProvider()
    @EnvironmentObject var loginStatus: LoginStatus
    
    var body: some View {
        VStack {
            if loginStatus.isLoggedIn {
                SalesList()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(LoginStatus())
}
