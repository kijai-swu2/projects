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
//    let
    
    var body: some View {
        VStack {
            if loginStatus.isLoggedIn || (UserDefaults.standard.string(forKey: "token") != nil) {
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
