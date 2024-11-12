//
//  Login.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var signInProvider = SignInProvider()
    @StateObject var signUpProvider = SignUpProvider()
    @EnvironmentObject var loginStatus: LoginStatus
    @State var id: String = "kitcat3"
    @State var password: String = "kitcat3"
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("아이디")
                TextField("", text: $id)
                    .padding()
                    .background(Color.textfield)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                    .autocapitalization(.none)
            }
            .padding(.bottom)
            VStack(alignment: .leading) {
                Text("비밀번호")
                SecureField("", text: $password)
                    .padding()
                    .background(Color.textfield)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
            }
            .padding(.bottom, 30)
            VStack {
                Button("로그인") {
                    signInProvider.signIn(id: id, password: password, status: loginStatus)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                Text("또는 위의 정보로")
                    .font(.subheadline)
                Button("회원가입") {
                    signUpProvider.signUp(id: id, password: password)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.secondary)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
            }
        }
        
        .padding()
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginStatus())
}
