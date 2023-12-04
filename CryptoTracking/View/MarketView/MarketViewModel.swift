//
//  MarketViewModel.swift
//  CryptoTracking
//
//  Created by DuyThai on 21/10/2023.
//

import Foundation
import Combine
import SwiftUI

enum FilterCoinType: Equatable {
    case rank(statusFilter: StatusFilter)
    case price(statusFilter: StatusFilter)
    case holding(statusFilter: StatusFilter)
    case percent(statusFilter: StatusFilter)
}

class MarketViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var allCoinsDisplay: [Coin] = []
    @Published var searchText: String = ""
    @Published var filterRankingStatus: StatusFilter = .off
    @Published var filterHoldingStatus: StatusFilter = .off
    @Published var filterPriceStatus: StatusFilter = .off
    @Published var filterType: FilterCoinType = .rank(statusFilter: .off)
    @Published var isHiddenLoadCoin: Bool = false

    private let coinServices = CoinDataService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscriber()
        getCoins(params: CoinMarketParam(vsCurrency: "usd", ids: nil, category: nil, order: "market_cap_desc", perPage: 100, page: 1, sparkline: true, priceChangePercentage: "1h", locale: "en", precision: "6"))
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//            self.allCoins.append(DeveloperPreview.shared.coin)
//        }
    }

    func log() {
        print("================================================================================================================================")
        print("[")
        for coin in allCoinsDisplay.prefix(9) {
            print("Coin(id: \"\(coin.id ?? "0")\", symbol: \"\(coin.symbol ?? "kk")\", name: \"\(coin.name ?? "N/A")\", image: \"\(coin.image ?? "N/A")\", currentPrice: \(coin.currentPrice ), marketCap: \(coin.marketCap ?? 0), marketCapRank: \(coin.marketCapRank ?? 0), fullyDilutedValuation: nil, totalVolume: nil, high24H: nil, low24H: nil, priceChange24H: \(coin.priceChange24H ?? 0), priceChangePercentage24H: \(coin.priceChangePercentage24H ?? 0), marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: \"\(coin.athDate ?? "N/A")\", atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: \"\(coin.lastUpdated ?? "N/A")\", sparklineIn7D:  SparklineIn7D(price: [")

            for price in coin.sparklineIn7D?.price ?? [] {
                print("\(price), ")
            }

            print("]),priceChangePercentage1HInCurrency: nil, currentHoldings: nil)")
        print(", \n")
        }
        print("]")
        print("================================================================================================================================")

    }
    private func addSubscriber() {
        coinServices.$allCoins
            .sink(receiveValue: { [weak self] coins in
                DispatchQueue.main.async {
                self?.allCoins = coins
                self?.allCoinsDisplay = coins

               }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self?.isHiddenLoadCoin = true
                }
            })
            .store(in: &cancellables)

        $searchText
            .combineLatest($allCoinsDisplay)
            .map { (text, startingCoins) -> [Coin] in
                if text == ""  {
                    return self.allCoins
                }
                let lowercasedText = text.lowercased()
                return startingCoins.filter { coin -> Bool in
                    return coin.name?.lowercased().contains(lowercasedText) ?? false ||
                    coin.symbol?.lowercased().contains(lowercasedText) ?? false ||
                    coin.id?.lowercased().contains(lowercasedText) ?? false
                }
            }
            .sink { [weak self] resultSearch in
                self?.allCoinsDisplay = resultSearch
            }
            .store(in: &cancellables)

        $filterType
            .sink(receiveValue: { [weak self] type in
                DispatchQueue.main.async {
                    self?.filterCoins(type: type)
                }
            })
            .store(in: &cancellables)

    }

    func getCoins(params: CoinMarketParam) {

        coinServices.getCoin(param: params)
    }

    func filterCoins(type: FilterCoinType) {
        self.isHiddenLoadCoin = false

        switch type {
        case .rank(let statusFilter):
            switch statusFilter {
            case .up:
                allCoinsDisplay = allCoins.sorted {$0.marketCapRank ?? 0 < $1.marketCapRank ?? 0}
            case .down:
                allCoinsDisplay = allCoins.sorted {$0.marketCapRank ?? 0 > $1.marketCapRank ?? 0}
            case .off:
                allCoinsDisplay = allCoins
            }
            self.isHiddenLoadCoin = true

        case .price(let statusFilter):
            switch statusFilter {
            case .up:
                allCoinsDisplay = allCoins.sorted {$0.currentPrice < $1.currentPrice}
            case .down:
                allCoinsDisplay = allCoins.sorted {$0.currentPrice > $1.currentPrice}
            case .off:
                allCoinsDisplay = allCoins
            }
            self.isHiddenLoadCoin = true

        case .holding(let statusFilter):
            log() 
            switch statusFilter {
            case .up:
                allCoinsDisplay = allCoins.sorted {$0.currentHoldings ?? 0 < $1.currentHoldings ?? 0}
            case .down:
                allCoinsDisplay = allCoins.sorted {$0.currentHoldings ?? 0 > $1.currentHoldings ?? 0}
            case .off:
                allCoinsDisplay = allCoins
            }
            self.isHiddenLoadCoin = true

        case .percent(let statusFilter):
            switch statusFilter {
            case .up:
                allCoinsDisplay = allCoins.sorted {$0.priceChangePercentage1HInCurrency ?? 0 < $1.priceChangePercentage1HInCurrency ?? 0}
            case .down:
                allCoinsDisplay = allCoins.sorted {$0.priceChangePercentage1HInCurrency ?? 0 > $1.priceChangePercentage1HInCurrency ?? 0}
            case .off:
                allCoinsDisplay = allCoins
            }
            self.isHiddenLoadCoin = true
        }
    }


}

