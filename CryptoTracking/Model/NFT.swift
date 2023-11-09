//
//  NFT.swift
//  CryptoTracking
//
//  Created by DuyThai on 09/11/2023.
//

import Foundation
// MARK: - Nft
struct NFT: Codable {
    let id, contractAddress, name: String?
    let assetPlatformID: AssetPlatformID?
    let symbol: String?

    enum CodingKeys: String, CodingKey {
        case id
        case contractAddress = "contract_address"
        case name
        case assetPlatformID = "asset_platform_id"
        case symbol
    }
}

enum AssetPlatformID: String, Codable {
    case klayToken = "klay-token"
}

typealias NFTs = [NFT]
