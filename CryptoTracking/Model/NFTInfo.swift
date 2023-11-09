//
//  NFTInfo.swift
//  CryptoTracking
//
//  Created by DuyThai on 09/11/2023.
//

import Foundation

// MARK: - NFTInfo
struct NFTInfo: Codable {
    let id, contractAddress, assetPlatformID, name: String?
    let symbol: String?
    let image: ImageCoin?
    let description, nativeCurrency, nativeCurrencySymbol: String?
    let floorPrice, marketCap, volume24H: FloorPrice?
    let floorPriceInUsd24HPercentageChange: Double?
    let floorPrice24HPercentageChange, marketCap24HPercentageChange, volume24HPercentageChange: FloorPrice?
    let numberOfUniqueAddresses, numberOfUniqueAddresses24HPercentageChange, volumeInUsd24HPercentageChange, totalSupply: Int?
    let oneDaySales, oneDaySales24HPercentageChange, oneDayAverageSalePrice, oneDayAverageSalePrice24HPercentageChange: Int?
    let links: Links?
    let floorPrice7DPercentageChange, floorPrice14DPercentageChange, floorPrice30DPercentageChange, floorPrice60DPercentageChange: FloorPrice?
    let floorPrice1YPercentageChange: FloorPrice?
    let explorers: [Explorer]?

    enum CodingKeys: String, CodingKey {
        case id
        case contractAddress = "contract_address"
        case assetPlatformID = "asset_platform_id"
        case name, symbol, image, description
        case nativeCurrency = "native_currency"
        case nativeCurrencySymbol = "native_currency_symbol"
        case floorPrice = "floor_price"
        case marketCap = "market_cap"
        case volume24H = "volume_24h"
        case floorPriceInUsd24HPercentageChange = "floor_price_in_usd_24h_percentage_change"
        case floorPrice24HPercentageChange = "floor_price_24h_percentage_change"
        case marketCap24HPercentageChange = "market_cap_24h_percentage_change"
        case volume24HPercentageChange = "volume_24h_percentage_change"
        case numberOfUniqueAddresses = "number_of_unique_addresses"
        case numberOfUniqueAddresses24HPercentageChange = "number_of_unique_addresses_24h_percentage_change"
        case volumeInUsd24HPercentageChange = "volume_in_usd_24h_percentage_change"
        case totalSupply = "total_supply"
        case oneDaySales = "one_day_sales"
        case oneDaySales24HPercentageChange = "one_day_sales_24h_percentage_change"
        case oneDayAverageSalePrice = "one_day_average_sale_price"
        case oneDayAverageSalePrice24HPercentageChange = "one_day_average_sale_price_24h_percentage_change"
        case links
        case floorPrice7DPercentageChange = "floor_price_7d_percentage_change"
        case floorPrice14DPercentageChange = "floor_price_14d_percentage_change"
        case floorPrice30DPercentageChange = "floor_price_30d_percentage_change"
        case floorPrice60DPercentageChange = "floor_price_60d_percentage_change"
        case floorPrice1YPercentageChange = "floor_price_1y_percentage_change"
        case explorers
    }
}

// MARK: - Explorer
struct Explorer: Codable {
    let name: String?
    let link: String?
}

// MARK: - FloorPrice
struct FloorPrice: Codable {
    let nativeCurrency, usd: Double?

    enum CodingKeys: String, CodingKey {
        case nativeCurrency = "native_currency"
        case usd
    }
}


