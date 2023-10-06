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
    let sparkline: Bool? = false
    let priceChangePercentage: String?
    let locale: String?
    let precision: String?
}

extension CoinMarketParam {
    var toDict: [String: Any] {
        return [
            "vsCurrency": vsCurrency,
            "ids": ids ?? "",
            "category": category ?? "",
            "order": order ?? "",
            "perPage": perPage ?? 100,
            "page": page ?? 1,
            "sparkline": sparkline ?? false,
            "priceChangePercentage": priceChangePercentage ?? "",
            "locale": locale ?? "",
            "precision": precision ?? ""
        ]
    }
}
