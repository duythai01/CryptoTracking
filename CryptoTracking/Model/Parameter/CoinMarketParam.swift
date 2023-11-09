//
//  CoinMarketParam.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation

struct CoinMarketParam {
    let vsCurrency: String
    let ids: String?
    let category: String?
    let order: String?
    let perPage: Int?
    let page: Int?
    let sparkline: Bool?
    let priceChangePercentage: String?
    let locale: String?
    let precision: String?
}

extension CoinMarketParam {
    func toDict() -> [String: Any] {
        var dict: [String: Any] =  ["vs_currency": vsCurrency]

        if let ids = ids {
            dict["ids"] = ids
        }
        if let category = category {
            dict["category"] = category

        }
        if let order = order {
            dict["order"] = order

        }
        if let perPage = perPage {
            dict["per_page"] = perPage

        }
        if let page = page {
            dict["page"] = page

        }
        if let sparkline = sparkline {
            dict["sparkline"] = sparkline

        }

        if let priceChangePercentage = priceChangePercentage {
            dict["price_change_percentage"] = priceChangePercentage

        }

        if let locale = locale {
            dict["locale"] = locale

        }

        if let precision = precision {
            dict["precision"] = precision

        }

        return dict
    }
}
