//
//  HomeRouter.swift
//  CryptoTracking
//
//  Created by DuyThai on 02/11/2023.
//

import Foundation
import SwiftUI

public enum AppRouter: NavigationRouter {
    case appView
    case buy
    case withdraw
    case p2p
    case receive
    case exchange
    case personal
    case onboarding
    case login
    case marketDetailView(url: String, title: String)

    public var transition: NavigationTranisitionStyle {
        switch self {
        case .buy:
            return .push
        case .withdraw:
            return .push
        case .p2p:
            return .push
        case .receive:
            return .push
        case .exchange:
            return .push
        case .appView:
            return .push
        case .personal:
            return .push
        case .onboarding:
            return .push
        case .login:
            return .push
        case .marketDetailView(let url, let title):
            return .push
        }
    }

    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .buy:
             BuyView()
        case .withdraw:
             WithdrawView()
        case .p2p:
            P2PView()
        case .receive:
            BuyView()
        case .exchange:
            BuyView()
        case .appView:
            ContentView()
        case .personal:
            PersonalView(coinsHolded: DeveloperPreview.shared.holdCoins)
        case .onboarding:
            OnboardingView()
        case .login:
            LoginView()
        case .marketDetailView(let url, let title):
            MarketDetailView(url: url, tilte: title)
        }
    }
}
