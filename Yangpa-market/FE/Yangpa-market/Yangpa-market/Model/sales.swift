//
//  sales.swift
//  Yangpa-market
//
//  Created by 서희재 on 11/6/24.
//

import Foundation

struct Sale: Codable {
    let id: Int
    let productName: String
    let description: String
    let price: Int
    let photo: String
    let userName: String
    let createdAt: String
}

struct SalesResult: Codable {
    let success: Bool
    let documents: [Sale]
    let message: String
}
