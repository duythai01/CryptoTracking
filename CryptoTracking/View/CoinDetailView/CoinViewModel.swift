//
//  CoinViewModel.swift
//  CryptoTracking
//
//  Created by DuyThai on 17/11/2023.
//

import Foundation
import Combine
import SwiftUI
class CoinViewModel: ObservableObject {
    @Published var filterType: FilterCoinType = .rank(statusFilter: .off)
    @Published var isHiddenLoadCoin: Bool = false

    private let coinServices = CoinDataService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscriber()
    }


    private func addSubscriber() {
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
                break
            case .down:
                break
            case .off:
                break
            }
            self.isHiddenLoadCoin = true

        case .price(let statusFilter):
            switch statusFilter {
            case .up:
                break
            case .down:
                break
            case .off:
                break

            }
            self.isHiddenLoadCoin = true

        case .holding(let statusFilter):
            switch statusFilter {
            case .up:
                break
            case .down:
                break
            case .off:
                break

            }
            self.isHiddenLoadCoin = true

        case .percent(let statusFilter):
            switch statusFilter {
            case .up:
                break
            case .down:
                break
            case .off:
                break
            }
            self.isHiddenLoadCoin = true
        }
    }


}
