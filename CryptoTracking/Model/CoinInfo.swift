//
//  CoinDetail.swift
//  CryptoTracking
//
//  Created by DuyThai on 09/11/2023.
//

import Foundation

// MARK: - CoinInfo
struct CoinInfo: Codable, Identifiable {
    let id: String
    let symbol, name: String?
    let assetPlatformID: String?
    let platforms: Platforms?
    let detailPlatforms: DetailPlatforms?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let previewListing: Bool?
    let publicNotice: String?
    let additionalNotices: [String]?
    let description: Description?
    let links: Links?
    let image: ImageCoin?
    let countryOrigin, genesisDate: String?
    let sentimentVotesUpPercentage, sentimentVotesDownPercentage: Double?
    let watchlistPortfolioUsers, marketCapRank, coingeckoRank: Int?
    let coingeckoScore, developerScore, communityScore, liquidityScore: Double?
    let publicInterestScore: Double?
    let marketData: MarketData?
    let communityData: CommunityData?
    let developerData: DeveloperData?
    let publicInterestStats: PublicInterestStats?
    let statusUpdates: [JSONAny]?
    let lastUpdated: String?
    let tickers: [Ticker]?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case assetPlatformID = "asset_platform_id"
        case platforms
        case detailPlatforms = "detail_platforms"
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case categories
        case previewListing = "preview_listing"
        case publicNotice = "public_notice"
        case additionalNotices = "additional_notices"
        case description, links, image
        case countryOrigin = "country_origin"
        case genesisDate = "genesis_date"
        case sentimentVotesUpPercentage = "sentiment_votes_up_percentage"
        case sentimentVotesDownPercentage = "sentiment_votes_down_percentage"
        case watchlistPortfolioUsers = "watchlist_portfolio_users"
        case marketCapRank = "market_cap_rank"
        case coingeckoRank = "coingecko_rank"
        case coingeckoScore = "coingecko_score"
        case developerScore = "developer_score"
        case communityScore = "community_score"
        case liquidityScore = "liquidity_score"
        case publicInterestScore = "public_interest_score"
        case marketData = "market_data"
        case communityData = "community_data"
        case developerData = "developer_data"
        case publicInterestStats = "public_interest_stats"
        case statusUpdates = "status_updates"
        case lastUpdated = "last_updated"
        case tickers
    }
}

// MARK: - CommunityData
struct CommunityData: Codable {
    let facebookLikes: Double?
    let twitterFollowers, redditAveragePosts48H, redditAverageComments48H, redditSubscribers: Double?
    let redditAccountsActive48H: Int?
    let telegramChannelUserCount: Double?

    enum CodingKeys: String, CodingKey {
        case facebookLikes = "facebook_likes"
        case twitterFollowers = "twitter_followers"
        case redditAveragePosts48H = "reddit_average_posts_48h"
        case redditAverageComments48H = "reddit_average_comments_48h"
        case redditSubscribers = "reddit_subscribers"
        case redditAccountsActive48H = "reddit_accounts_active_48h"
        case telegramChannelUserCount = "telegram_channel_user_count"
    }
}

// MARK: - Description
struct Description: Codable {
    let en, de, es, fr: String?
    let it, pl, ro, hu: String?
    let nl, pt, sv, vi: String?
    let tr, ru, ja, zh: String?
    let zhTw, ko, ar, th: String?
    let id, cs, da, el: String?
    let hi, no, sk, uk: String?
    let he, fi, bg, hr: String?
    let lt, sl: String?

    enum CodingKeys: String, CodingKey {
        case en, de, es, fr, it, pl, ro, hu, nl, pt, sv, vi, tr, ru, ja, zh
        case zhTw = "zh-tw"
        case ko, ar, th, id, cs, da, el, hi, no, sk, uk, he, fi, bg, hr, lt, sl
    }
}

// MARK: - DetailPlatforms
struct DetailPlatforms: Codable {
    let empty: Empty?

    enum CodingKeys: String, CodingKey {
        case empty = ""
    }
}

// MARK: - Empty
struct Empty: Codable {
    let decimalPlace: JSONNull?
    let contractAddress: String?

    enum CodingKeys: String, CodingKey {
        case decimalPlace = "decimal_place"
        case contractAddress = "contract_address"
    }
}

// MARK: - DeveloperData
struct DeveloperData: Codable {
    let forks, stars, subscribers, totalIssues: Int?
    let closedIssues, pullRequestsMerged, pullRequestContributors: Int?
    let codeAdditionsDeletions4_Weeks: CodeAdditionsDeletions4_Weeks?
    let commitCount4_Weeks: Int?
    let last4_WeeksCommitActivitySeries: [Int]?

    enum CodingKeys: String, CodingKey {
        case forks, stars, subscribers
        case totalIssues = "total_issues"
        case closedIssues = "closed_issues"
        case pullRequestsMerged = "pull_requests_merged"
        case pullRequestContributors = "pull_request_contributors"
        case codeAdditionsDeletions4_Weeks = "code_additions_deletions_4_weeks"
        case commitCount4_Weeks = "commit_count_4_weeks"
        case last4_WeeksCommitActivitySeries = "last_4_weeks_commit_activity_series"
    }
}

// MARK: - CodeAdditionsDeletions4_Weeks
struct CodeAdditionsDeletions4_Weeks: Codable {
    let additions, deletions: Int?
}

enum ID: String, Codable {
    case binancecoin = "binancecoin"
    case bitcoin = "bitcoin"
    case chainlink = "chainlink"
    case cosmos = "cosmos"
    case ethereum = "ethereum"
    case ripple = "ripple"
    case solana = "solana"
    case wrappedBitcoin = "wrapped-bitcoin"
    case zcash = "zcash"
}

// MARK: - Image
struct ImageCoin: Codable {
    let thumb, small, large: String?
}

// MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let blockchainSite, officialForumURL: [String]?
    let chatURL, announcementURL: [String]?
    let twitterScreenName: ID?
    let facebookUsername: String?
    let bitcointalkThreadIdentifier: String?
    let telegramChannelIdentifier: String?
    let subredditURL: String?
    let reposURL: ReposURL?
    let twitter: String?
    let discord: JSONNull?

    enum CodingKeys: String, CodingKey {
        case homepage
        case blockchainSite = "blockchain_site"
        case officialForumURL = "official_forum_url"
        case chatURL = "chat_url"
        case announcementURL = "announcement_url"
        case twitterScreenName = "twitter_screen_name"
        case facebookUsername = "facebook_username"
        case bitcointalkThreadIdentifier = "bitcointalk_thread_identifier"
        case telegramChannelIdentifier = "telegram_channel_identifier"
        case subredditURL = "subreddit_url"
        case reposURL = "repos_url"
        case discord
        case twitter
    }
}

// MARK: - ReposURL
struct ReposURL: Codable {
    let github: [String]?
    let bitbucket: [JSONAny]?
}

// MARK: - MarketData
struct MarketData: Codable {
    let currentPrice: [String: Double]?
    let totalValueLocked, mcapToTvlRatio, fdvToTvlRatio, roi: Roi?
    let ath, athChangePercentage: [String: Double]?
    let athDate: [String: String]?
    let atl, atlChangePercentage: [String: Double]?
    let atlDate: [String: String]?
    let marketCap: [String: Double]?
    let marketCapRank: Int?
    let fullyDilutedValuation: [String: Double]?
    let marketCapFdvRatio: Double?
    let totalVolume, high24H, low24H: [String: Double]?
    let priceChange24H, priceChangePercentage24H, priceChangePercentage7D, priceChangePercentage14D: Double?
    let priceChangePercentage30D, priceChangePercentage60D, priceChangePercentage200D, priceChangePercentage1Y: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let priceChange24HInCurrency, priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: [String: Double]?
    let priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency, priceChangePercentage60DInCurrency, priceChangePercentage200DInCurrency: [String: Double]?
    let priceChangePercentage1YInCurrency, marketCapChange24HInCurrency, marketCapChangePercentage24HInCurrency: [String: Double]?
    let totalSupply, maxSupply, circulatingSupply: Double?
    let sparkline7D: SparklineIn7D?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case totalValueLocked = "total_value_locked"
        case mcapToTvlRatio = "mcap_to_tvl_ratio"
        case fdvToTvlRatio = "fdv_to_tvl_ratio"
        case roi, ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case marketCapFdvRatio = "market_cap_fdv_ratio"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case priceChangePercentage7D = "price_change_percentage_7d"
        case priceChangePercentage14D = "price_change_percentage_14d"
        case priceChangePercentage30D = "price_change_percentage_30d"
        case priceChangePercentage60D = "price_change_percentage_60d"
        case priceChangePercentage200D = "price_change_percentage_200d"
        case priceChangePercentage1Y = "price_change_percentage_1y"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case priceChange24HInCurrency = "price_change_24h_in_currency"
        case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
        case priceChangePercentage14DInCurrency = "price_change_percentage_14d_in_currency"
        case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
        case priceChangePercentage60DInCurrency = "price_change_percentage_60d_in_currency"
        case priceChangePercentage200DInCurrency = "price_change_percentage_200d_in_currency"
        case priceChangePercentage1YInCurrency = "price_change_percentage_1y_in_currency"
        case marketCapChange24HInCurrency = "market_cap_change_24h_in_currency"
        case marketCapChangePercentage24HInCurrency = "market_cap_change_percentage_24h_in_currency"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
        case sparkline7D = "sparkline_7d"
        case lastUpdated = "last_updated"
    }
}

// MARK: - Platforms
struct Platforms: Codable {
    let empty: String?

    enum CodingKeys: String, CodingKey {
        case empty = ""
    }
}

// MARK: - PublicInterestStats
struct PublicInterestStats: Codable {
    let alexaRank: Int?
    let bingMatches: Double?

    enum CodingKeys: String, CodingKey {
        case alexaRank = "alexa_rank"
        case bingMatches = "bing_matches"
    }
}

// MARK: - Ticker
struct Ticker: Codable {
    let base: String?
    let target: String?
    let market: Market?
    let last, volume: Double?
    let convertedLast, convertedVolume: [String: Double]?
    let trustScore: String?
    let bidAskSpreadPercentage: Double?
    let timestamp, lastTradedAt, lastFetchAt: String?
    let isAnomaly, isStale: Bool?
    let tradeURL: String?
    let tokenInfoURL: String?
    let coinID: String?
    let targetCoinID: String?

    enum CodingKeys: String, CodingKey {
        case base, target, market, last, volume
        case convertedLast = "converted_last"
        case convertedVolume = "converted_volume"
        case trustScore = "trust_score"
        case bidAskSpreadPercentage = "bid_ask_spread_percentage"
        case timestamp
        case lastTradedAt = "last_traded_at"
        case lastFetchAt = "last_fetch_at"
        case isAnomaly = "is_anomaly"
        case isStale = "is_stale"
        case tradeURL = "trade_url"
        case tokenInfoURL = "token_info_url"
        case coinID = "coin_id"
        case targetCoinID = "target_coin_id"
    }
}

// MARK: - Market
struct Market: Codable {
    let name, identifier: String?
    let hasTradingIncentive: Bool?

    enum CodingKeys: String, CodingKey {
        case name, identifier
        case hasTradingIncentive = "has_trading_incentive"
    }
}

enum Target: String, Codable {
    case btc = "BTC"
    case busd = "BUSD"
    case gbp = "GBP"
    case jpy = "JPY"
    case tusd = "TUSD"
    case usd = "USD"
    case usdc = "USDC"
    case usdt = "USDT"
    case xbt = "XBT"
}



// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
