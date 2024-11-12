//
//  ContentView.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginStatus: LoginStatus
    
    var body: some View {
        MainView()
    }
}

#Preview {
    ContentView()
        .environmentObject(LoginStatus())
}
