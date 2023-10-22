//
//  API.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation

enum BaseUrl: String {
    case mainnet = "https://api.etherscan.io/api"
    case goerli = "https://api-goerli.etherscan.io/api"
    case sepolia = "https://api-sepolia.etherscan.io/api"
    case coinGekko = "https://api.coingecko.com/api/v3/"
    case mock = "https://6c7ea76e-47ae-430d-bcfe-648ea3f827b7.mock.pstmn.io/"
}
