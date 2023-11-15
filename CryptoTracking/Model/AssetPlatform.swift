//
//  AssetPlatform.swift
//  CryptoTracking
//
//  Created by DuyThai on 09/11/2023.
//

import Foundation
struct AssetPlatformElement: Codable, Identifiable {
    let id: String
    let chainIdentifier: Int?
    let name, shortname: String?
    let img: String?
    let url: String?
    enum CodingKeys: String, CodingKey {
        case id
        case chainIdentifier = "chain_identifier"
        case name, shortname, img, url
    }
}

typealias AssetPlatform = [AssetPlatformElement]
