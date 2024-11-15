//
//  YangpaMarket_1App.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import SwiftUI

@main
struct YangpaMarket_1App: App {
    @StateObject var loginStatus = LoginStatus()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginStatus)
        }
    }
}
