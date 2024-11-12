//
//  Sales.swift
//  YangpaMarket-1
//
//  Created by 서희재 on 11/12/24.
//

import Foundation

struct Sale: Codable, Identifiable {
    let id: Int
    let productName: String
    let description: String
    let price: Int
    let photo: String
    let userName: String
    let createdAt: String
    var photoURL: URL?
}

struct SalesResult: Codable {
    let success: Bool
    let documents: [Sale]
    let message: String
}

