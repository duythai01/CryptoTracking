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
    case nftDetailView(url: String, title: String)
    case coinDetail(id: String, currency: String)
    case newsView
    case newsDetail(url: String)
    case afterScan(url: String)

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
        case .login, .newsView:
            return .push
        case .nftDetailView(_, _):
            return .push
        case .coinDetail(_, _):
            return .push
        case .newsDetail(_), .afterScan(_):
            return .push
        }
    }

    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .buy:
            MarketView()
        case .withdraw:
             WithdrawView()
        case .p2p:
            P2PView()
        case .receive:
            MarketView()
        case .exchange:
            ExchangeView()
        case .appView:
            ContentView()
        case .personal:
            PersonalView(coinsHolded: DeveloperPreview.shared.holdCoins)
        case .onboarding:
            OnboardingView()
        case .login:
            LoginView()
        case .nftDetailView(let url, let title):
            NFTDetailView(url: url, tilte: title)
        case .coinDetail(id: let id, let currency):
            CoinDetailView(coinID: id, currency: currency )
        case .newsView:
            NewsView()
        case .newsDetail(let url):
            NewsDetailView(url: url, tilte: "")
        case .afterScan(let url):
            AfterScanView(url: url, tilte: "PAYMENT")
        }
    }
}
