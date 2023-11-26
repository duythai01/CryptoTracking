//
//  Article.swift
//  CryptoTracking
//
//  Created by DuyThai on 23/11/2023.
//
import Foundation

// MARK: - Article
struct Article: Codable {
    let status: String?
    let totalResults: Int?
    let results: [ResultArticles]?
    let nextPage: String?
}

// MARK: - Result
struct ResultArticles: Codable, Identifiable {
    var id: String
    let title: String?
    let link: String?
    let keywords: [String]?
    let creator: [String]?
    let videoURL: String?
    let description, content, pubDate: String?
    let imageURL: String?
    let sourceID: String?
    let sourcePriority: Int?
    let country: [String]?
    let category: [String]?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id = "article_id"
        case title, link, keywords, creator
        case videoURL = "video_url"
        case description, content, pubDate
        case imageURL = "image_url"
        case sourceID = "source_id"
        case sourcePriority = "source_priority"
        case country, category, language
    }
}

enum Category: String, Codable {
    case science = "science"
    case technology = "technology"
    case top = "top"
}

enum Country: String, Codable {
    case australia = "australia"
    case unitedStatesOfAmerica = "united states of america"
}

enum Creator: Codable {
    case string(String)
    case stringArray([String])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Creator.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Creator"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

enum Language: String, Codable {
    case english = "english"
}

