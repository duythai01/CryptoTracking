//
//  Home.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation
import SwiftUI

enum HomeCategory: String, CaseIterable, Identifiable {
    var id: Int { self.hashValue }

    case buy
    case swap
    case withdraw
    case receive
    case exchange
    var displayName: String {
        switch self {
        case .buy:
            return "Buy"
        case .swap:
            return "Withdraw"
        case .withdraw:
            return "Send"
        case .receive:
            return "Receive"
        case .exchange:
            return "Exchange"

        }
    }

    var image: Image {
        switch self {
        case .buy:
            return Image(systemName: "cart.fill")
        case .swap:
            return Image("ic_withdraw")
        case .withdraw:
            return Image(systemName:"square.and.arrow.up.fill")
        case .receive:
            return Image(systemName:"square.and.arrow.down.fill")
        case .exchange:
            return Image(systemName: "arrow.up.arrow.down.circle.fill")
        }
    }
}
