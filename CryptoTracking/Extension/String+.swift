//
//  String+.swift
//  CryptoTracking
//
//  Created by DuyThai on 21/10/2023.
//

import Foundation

extension String {
    func checkIsIncrease() -> Bool {
        return self.prefix(1) == "+"
    }
}

extension String {
    static let coinMarket = "coins/markets"
}
