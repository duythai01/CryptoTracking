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

    case market
    case withdraw
    case p2p
    case receive
    case exchange
    var displayName: String {
        switch self {
        case .market:
            return "Market"
        case .withdraw:
            return "Withdraw"
        case .p2p:
            return "P2P"
        case .receive:
            return "Web3"
        case .exchange:
            return "Exchange"

        }
    }

    var image: Image {
        switch self {
        case .market:
            return Image(systemName: "cart.fill")
        case .p2p:
            return Image(systemName: "person.2.fill")
        case .withdraw:
            return Image(systemName:"square.and.arrow.up.fill")
        case .receive:
            return Image(systemName:"square.and.arrow.down.fill")
        case .exchange:
            return Image(systemName: "arrow.up.arrow.down.circle.fill")
        }
    }
}
