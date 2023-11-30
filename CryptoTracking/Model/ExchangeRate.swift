//
//  ExchangeRate.swift
//  CryptoTracking
//
//  Created by DuyThai on 29/11/2023.
//

import Foundation
// MARK: - ExchangeRate
struct ExchangeRate: Codable {
    let rates: [String: Rate]?
}

// MARK: - Rate
struct Rate: Codable, Equatable {
    let name, unit: String?
    let value: Double?
    let type: RateType?
}

enum RateType: String, Codable {
    case commodity = "commodity"
    case crypto = "crypto"
    case fiat = "fiat"
}
