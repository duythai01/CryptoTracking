//
//  WithdrawRouter.swift
//  CryptoTracking
//
//  Created by DuyThai on 02/11/2023.
//

import Foundation
import SwiftUI

public enum WithdrawRouter: NavigationRouter {
    case buy
    case withdraw
    case send
    case receive
    case exchange

    public var transition: NavigationTranisitionStyle {
        switch self {
        case .buy:
            return .push
        case .withdraw:
            return .push
        case .send:
            return .push
        case .receive:
            return .push
        case .exchange:
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
        case .send:
            BuyView()
        case .receive:
            BuyView()
        case .exchange:
            BuyView()

        }
    }
}
