//
//  Date+.swift
//  CryptoTracking
//
//  Created by DuyThai on 28/11/2023.
//

import Foundation

extension Date {
    func formatDateTo(type: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }
}
