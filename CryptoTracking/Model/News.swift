//
//  News.swift
//  CryptoTracking
//
//  Created by DuyThai on 23/11/2023.
//

import Foundation

// MARK: - News
struct News: Codable {
    let results: [ResultNews]?
    let status, requestID: String?
    let count: Int?
    let nextURL: String?

    enum CodingKeys: String, CodingKey {
        case results = "results"
        case status
        case requestID = "request_id"
        case count
        case nextURL = "next_url"
    }
}

// MARK: - Result
struct ResultNews: Codable, Identifiable {
    let id: String?
    let publisher: Publisher?
    let title, author: String?
    let publishedUTC: Date?
    let articleURL: String?
    let tickers: [String]?
    let ampURL: String?
    let imageURL: String?
    let description: String?
    let keywords: [String]?

    enum CodingKeys: String, CodingKey {
        case id, publisher, title, author
        case publishedUTC = "published_utc"
        case articleURL = "article_url"
        case tickers
        case ampURL = "amp_url"
        case imageURL = "image_url"
        case description, keywords
    }
}

// MARK: - Publisher
struct Publisher: Codable {
    let name: Name?
    let homepageURL: String?
    let logoURL: String?
    let faviconURL: String?

    enum CodingKeys: String, CodingKey {
        case name
        case homepageURL = "homepage_url"
        case logoURL = "logo_url"
        case faviconURL = "favicon_url"
    }
}

enum Name: String, Codable {
    case globeNewswireInc = "GlobeNewswire Inc."
    case marketWatch = "MarketWatch"
    case theMotleyFool = "The Motley Fool"
    case zacksInvestmentResearch = "Zacks Investment Research"
}
