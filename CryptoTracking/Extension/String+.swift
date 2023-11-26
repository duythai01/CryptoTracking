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

    func isoFormatDateString() -> String {
        let dateString = self
        let isoDateFormatter = ISO8601DateFormatter()
        if let date = isoDateFormatter.date(from: dateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd"

            let formattedDate = outputDateFormatter.string(from: date)
            return formattedDate
            } else {
                return ""
        }
    }
}
