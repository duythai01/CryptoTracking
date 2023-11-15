//
//  Withdraw.swift
//  CryptoTracking
//
//  Created by DuyThai on 01/11/2023.
//

import Foundation
import SwiftUI

enum WithDrawMethodType: CaseIterable {
    case card
//    case p2pExpresee
//    case p2p
    case bank

    var name: String {
        switch self {
        case .card:
            return "Debit/Credit Card"
//        case .p2pExpresee:
//            return "P2P Express"
//        case .p2p:
//            return "P2P"
        case .bank:
            return "Bank Transfer"
        }
    }

    var icon: Image {
        switch self {
        case .card:
            return Image(systemName: "creditcard.fill")
//        case .p2pExpresee:
//            return Image(systemName: "person.2.gobackward")
//        case .p2p:
//            return Image(systemName: "person.2.fill")
        case .bank:
            return Image(systemName: "house.lodge.circle.fill")
        }
    }
}

enum WithdrawSheetSelection {
    case changeCoin
    case receiveCoin
    case paymentMethod
    case depositMethod
    case depositCoin
    case depositNetwork
    case flag
    case payment
    case filter
    case none

    var sectionTitle: String {
        switch self {
        case .changeCoin:
            return "Select currency"
        case .receiveCoin:
            return "Select currency"
        case .paymentMethod:
            return "Select withdraw method payment"
        case .depositMethod:
            return "Select deposit method payment"
        case .depositCoin:
            return "Select currency"
        case .depositNetwork:
            return "Select Network"
        case .none:
            return ""
        case .flag:
            return "Select fiat"
        case .payment:
            return ""
        case .filter:
            return "Filter"
        }
    }
}


struct PaymentChanel: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let image: String
    let exchangeRate: String
    let tag: [String]
    let paymentSupport: [PaymentSuportType]
}

enum PaymentSuportType: CaseIterable {
    case masterCard
    case visa
    case googlePay
    case applePay
    case payPal


    var icon: Image {
        switch self {
        case .masterCard:
            return Image("ic_mastercard")
        case .visa:
            return Image("ic_visa")
        case .googlePay:
            return Image("ic_google_pay")
        case .applePay:
            return Image("ic_apple_pay")
        case .payPal:
            return Image("ic_paypal")
        }
    }
}
