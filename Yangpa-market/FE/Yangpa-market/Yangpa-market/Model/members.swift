//
//  Model.swift
//  Yangpa-market
//
//  Created by 서희재 on 11/6/24.
//

import Foundation

struct Member: Codable {
    let userName: String
}

struct SignUpResult: Codable {
    let success: Bool
    let member: Member
    let message: String
}

struct SignInResult: Codable {
    let success: Bool
    let token: String
    let member: Member
    let message: String
}
