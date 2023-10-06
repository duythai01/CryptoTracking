//
//  MainTabBar.swift
//  CryptoTracking
//
//  Created by DuyThai on 04/10/2023.
//

import Foundation

enum MainTabBar: String, CaseIterable {
    case home
    case history
    case qr
    case transaction
    case setting

    var displayName: String {
        switch self {
        case .home:
            return "Home"
        case .history:
            return "History"
        case .qr:
            return "Qr"
        case .transaction:
            return "Transaction"
        case .setting:
            return "Setting"
        }
        }

    var icon: String{
        switch self {
        case .home:
            return "house.fill"
        case .history:
            return "list.bullet.clipboard.fill"
        case .qr:
            return "qrcode.viewfinder"
        case .transaction:
            return "arrow.up.arrow.down"
        case .setting:
            return "gearshape"
        }
    }
}
