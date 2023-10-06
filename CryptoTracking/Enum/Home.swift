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
    case send
    case receive
    case exchange
    case test1
    case test2
    case test3
    case test4
    var displayName: String {
        switch self {
        case .buy:
            return "Buy"
        case .swap:
            return "Swap"
        case .send:
            return "Send"
        case .receive:
            return "Receive"
        case .exchange:
            return "Exchange"
        case .test1:
            return "Exchange"
        case .test2:
            return "Exchange"
        case .test3:
            return "Exchange"
        case .test4:
            return "Exchange"
        }
    }

    var image: Image {
        switch self {
        case .buy:
            return Image(systemName: "cart.fill")
        case .swap:
            return Image(systemName: "repeat.circle.fill")
        case .send:
            return Image(systemName:"square.and.arrow.up.fill")
        case .receive:
            return Image(systemName:"square.and.arrow.down.fill")
        case .exchange:
            return Image(systemName: "arrow.up.arrow.down.circle.fill")
        case .test1:
            return Image(systemName: "arrow.up.arrow.down.circle.fill")
        case .test2:
            return Image(systemName: "arrow.up.arrow.down.circle.fill")
        case .test3:
            return Image(systemName: "arrow.up.arrow.down.circle.fill")
        case .test4:
            return Image(systemName: "arrow.up.arrow.down.circle.fill")

        }
    }
}
