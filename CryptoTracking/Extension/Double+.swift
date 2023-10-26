//
//  Double+.swift
//  CryptoTracking
//
//  Created by DuyThai on 21/10/2023.
//

import Foundation

extension Double {
    var currencyFormatter6: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true
        formater.numberStyle = .currency
        formater.locale = Locale(identifier: "usa")
        formater.maximumFractionDigits = 6
        formater.minimumFractionDigits = 2
        return formater
    }

    func asCurrencyWithSixDecimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "0"
    }
}
