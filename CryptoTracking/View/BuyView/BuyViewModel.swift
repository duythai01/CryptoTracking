//
//  BuyViewModel.swift
//  CryptoTracking
//
//  Created by DuyThai on 21/10/2023.
//

import Foundation
import Combine

enum FilterCoinType: Equatable {
    case rank(statusFilter: StatusFilter)
    case price(statusFilter: StatusFilter)
    case holding(statusFilter: StatusFilter)
    case percent(statusFilter: StatusFilter)
}

class BuyViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var allCoinsDisplay: [Coin] = []
    @Published var searchText: String = ""
    @Published var filterRankingStatus: StatusFilter = .off
    @Published var filterHoldingStatus: StatusFilter = .off
    @Published var filterPriceStatus: StatusFilter = .off
    @Published var filterType: FilterCoinType = .rank(statusFilter: .off)
    @Published var showLoadingCoins: Bool = true

    private let coinServices = CoinDataService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscriber()
        getCoins(params: CoinMarketParam(vsCurrency: "usd", ids: nil, category: nil, order: "market_cap_desc", perPage: 100, page: 1, sparkline: true, priceChangePercentage: "1h", locale: "en", precision: "6"))
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//            self.allCoins.append(DeveloperPreview.shared.coin)
//        }
    }

    private func addSubscriber() {
        coinServices.$allCoins
            .sink(receiveValue: { [weak self] coins in
                DispatchQueue.main.async {
                self?.allCoins = coins
                self?.allCoinsDisplay = coins
                self?.showLoadingCoins = false
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

        case .price(let statusFilter):
            switch statusFilter {
            case .up:
                allCoinsDisplay = allCoins.sorted {$0.currentPrice < $1.currentPrice}
            case .down:
                allCoinsDisplay = allCoins.sorted {$0.currentPrice > $1.currentPrice}
            case .off:
                allCoinsDisplay = allCoins
            }
        case .holding(let statusFilter):
            switch statusFilter {
            case .up:
                allCoinsDisplay = allCoins.sorted {$0.currentHoldings ?? 0 < $1.currentHoldings ?? 0}
            case .down:
                allCoinsDisplay = allCoins.sorted {$0.currentHoldings ?? 0 > $1.currentHoldings ?? 0}
            case .off:
                allCoinsDisplay = allCoins
            }

        case .percent(let statusFilter):
            switch statusFilter {
            case .up:
                allCoinsDisplay = allCoins.sorted {$0.priceChangePercentage1HInCurrency ?? 0 < $1.priceChangePercentage1HInCurrency ?? 0}
            case .down:
                allCoinsDisplay = allCoins.sorted {$0.priceChangePercentage1HInCurrency ?? 0 > $1.priceChangePercentage1HInCurrency ?? 0}
            case .off:
                allCoinsDisplay = allCoins
            }


        }
    }


}

