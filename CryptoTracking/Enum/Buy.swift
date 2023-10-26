//
//  Buy.swift
//  CryptoTracking
//
//  Created by DuyThai on 23/10/2023.
//

import Foundation
import SwiftUI

enum CategoryBuy: CaseIterable {
    case spot
    case futures
    case gainners
    case earn
    case new

    var name: String {
        switch self {
        case .spot:
            return "Spot"
        case .futures:
            return "Futures"
        case .gainners:
            return "Gainer"
        case .earn:
            return "Earn"
        case .new:
            return "New"
        }
    }
}

enum CoinDefault: CaseIterable {
    case usdt
    case usdts
    case btc
    case eth
    case etf
    case new
    case zone

    var name: String {
        switch self {
        case .usdt:
            return "USDT"
        case .usdts:
            return "USDT©"
        case .btc:
            return "BTC"
        case .eth:
            return "ETH"
        case .etf:
            return "ETF"
        case .new:
            return "New"
        case .zone:
            return "Zones"
        }
    }
}

enum StatusFilter {
    case up
    case down
    case off
}
