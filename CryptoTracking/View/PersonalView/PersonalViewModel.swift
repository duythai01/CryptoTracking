//
//  PersonalViewModel.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/11/2023.
//

import Foundation
import Combine
import SwiftUI


class PersonalViewModel: ObservableObject {
    @Published var coinsHolded: [CoinHolded] = []
    @Published var allCoinsDisplay: [Coin] = []
    @Published var searchText: String = ""
    @Published var filterRankingStatus: StatusFilter = .off
    @Published var filterHoldingStatus: StatusFilter = .off
    @Published var filterPriceStatus: StatusFilter = .off
    @Published var filterType: FilterCoinType = .rank(statusFilter: .off)
    @Published var showLoadingCoins: Bool = true

    private let coreDataController = CoreDataController.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscriber()
    }

    private func addSubscriber() {

    }

}


