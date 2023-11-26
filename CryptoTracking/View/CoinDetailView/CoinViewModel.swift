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
    @Published var sliderValuePercent: Double = 0
    @Published var amount: String = "0"
    @Published var balance: String = "3.960000"
    @Published var ratioCurrency: String = "37400"
    @Published var isStar: Bool = false

    private let coinServices = CoinDataService.shared
    private var cancellables = Set<AnyCancellable>()
    private let coreData = CoreDataController.shared
    init() {
        addSubscriber()


    }


    private func addSubscriber() {
        Publishers.CombineLatest3($sliderValuePercent, $ratioCurrency, $balance)
            .sink { [weak self] valueSlider, ratioValue, balanceValue in
                if let doubleValue = Decimal(string: ratioValue), let bal = Decimal(string: balanceValue) {
                    let inCrease = ((valueSlider * NSDecimalNumber(decimal: bal).doubleValue) / NSDecimalNumber(decimal: doubleValue).doubleValue )
                    self?.amount = "\(inCrease.formatTwoNumbeAfterDot(minimumFractionDigits: 0, maximumFractionDigits: 6))"
                }
            }
            .store(in: &cancellables)
//        $sliderValuePercent.sink(receiveValue: { [weak self] value in
//            if let doubleValue = Decimal(string: amount), let bal = Decimal(string: balance) {
//                let inCrease = (NSDecimalNumber(decimal: doubleValue).doubleValue * sliderValuePercent * NSDecimalNumber(decimal: bal).doubleValue)
//                amount = "\(inCrease)"
//            }
//        })
//        .store(in: &cancellables)

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

    func checkIsEixstCoreData(coinID: String) {
        if  coreData.getEntityByID(id: coinID) != nil {
            isStar = true
        } else {
            isStar = false
        }
    }

    func switchSaveToCoreDate(coinID: String) {
        print("@@@ coreData.fetchAllEntities(): \(coreData.fetchAllEntities())")
        if isStar {
            if coreData.deleteEntity(id: coinID) {
                isStar = false

            }
        } else {
            if coreData.insert(element: CoinHolded(id: coinID, currencyHold: 0.2)) {
                isStar = true
            }
        }
    }

}
