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

    func addPlusOrMinus() -> String {
       if  self.prefix(1) != "-" {
           if self.prefix(1) == "+" {
               let firstCharacter = self.prefix(1)
               let remainingCharacters = self.suffix(from: self.index(self.startIndex, offsetBy: 1))
               return "\(firstCharacter) \(remainingCharacters)"
           } else {
               return "+ \(self)"
           }
       } else  {
           let firstCharacter = self.prefix(1)
           let remainingCharacters = self.suffix(from: self.index(self.startIndex, offsetBy: 1))
           return "\(firstCharacter) \(remainingCharacters)"

       }
    }

    func formatDateTo(type: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

extension String {
    static let coinMarket = "coins/markets"
    static let assetPlatform = "asset_platforms?filter=nft"
}
