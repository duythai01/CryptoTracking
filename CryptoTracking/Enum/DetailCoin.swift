//
//  DetailCoin.swift
//  CryptoTracking
//
//  Created by DuyThai on 28/11/2023.
//

import Foundation

enum DetailInfoType: CaseIterable {
    case openOrder
    case trade
    case asset
    case strategy

    var name: String {
        switch self {
        case .openOrder:
            return "Open Orders"
        case .trade:
            return "Trades"
        case .asset:
            return "Assets"
        case .strategy:
            return "Strategy"
        }
    }

    var type: [String] {
        switch self {
        case .openOrder:
            return ["Limit/Market", "Conditional", "Time Condition"]
        case .trade:
            return ["My Trades", "All Trades"]
        case .asset:
            return []
        case .strategy:
            return ["Recommendations", "Most Profitable", "Most copied", "Return", "Follow's Funding", "Profits for Copy Trader"]
        }
    }
}


struct RealTimeOrder: Hashable {
    let amount: Double
    let currencyVs: String
    let currency: String
    let rate: Double

    var valueVs: Double {
        return amount * rate
    }

    // Implement Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(amount)
        hasher.combine(currencyVs)
        hasher.combine(currency)
        hasher.combine(rate)
    }
}



struct RealTimeAllTrade: Identifiable {
    let id = UUID().uuidString
    let time = Date()
    let price: Double
    let vsCurrency: String
    let currency: String
    let amount: Double
    let isBuy: Bool
    var valueVs: Double {
        return amount * price
    }
}
