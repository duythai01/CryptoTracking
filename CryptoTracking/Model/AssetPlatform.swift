//
//  AssetPlatform.swift
//  CryptoTracking
//
//  Created by DuyThai on 09/11/2023.
//

import Foundation
struct AssetPlatformElement: Codable {
    let id: String?
    let chainIdentifier: Int?
    let name, shortname: String?

    enum CodingKeys: String, CodingKey {
        case id
        case chainIdentifier = "chain_identifier"
        case name, shortname
    }
}

typealias AssetPlatform = [AssetPlatformElement]
