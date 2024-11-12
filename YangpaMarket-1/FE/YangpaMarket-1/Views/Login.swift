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
    @State var id: String = ""
    @State var password: String = ""
    @State var isLoggedIn = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("아이디")
                TextField("", text: $id)
                    .padding()
                    .background(Color.textField)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                    .autocapitalization(.none)
            }
            .padding(.bottom)
            VStack(alignment: .leading) {
                Text("비밀번호")
                SecureField("", text: $password)
                    .padding()
                    .background(Color.textField)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
            }
            .padding(.bottom, 30)
            VStack {
                Button("로그인") {
                    signInProvider.signIn(id: id, password: password)
                }
                .padding()
                .background(Color.accentColor)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                .frame(maxWidth: .infinity)
                Text("또는 위의 정보로")
                    .font(.subheadline)
                Button("회원가입") {
                    signUpProvider.signUp(id: id, password: password)
                }
                .padding()
                .background(Color.secondary)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        
        .padding()
    }
}

#Preview {
    LoginView()
}
