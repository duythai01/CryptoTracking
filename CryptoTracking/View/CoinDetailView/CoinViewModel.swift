//
//  CoinViewModel.swift
//  CryptoTracking
//
//  Created by DuyThai on 17/11/2023.
//

import Foundation
import Combine
import SwiftUI
import Charts
class CoinViewModel: ObservableObject {
    @Published var filterType: FilterCoinType = .rank(statusFilter: .off)
    @Published var isHiddenLoadCoin: Bool = false
    @Published var sliderValuePercent: Double = 0
    @Published var amount: String = "0"
    @Published var balance: String = "3.960000"
    @Published var ratioCurrency: String = "37400"
    @Published var isStar: Bool = false
    @Published var orders: [OrderHolded] = []

    @Published var priceIn7D: [Double] = []
    @Published var high24hUSD: Double = 36339.2
    @Published var low24hUSD: Double = 36320.5
    @Published var currentPrice: Double = 0

    @Published var dataTransaction: [RealTimeOrder] = [
   RealTimeOrder(amount: 0.1234, currencyVs: "USDT", currency: "BTC", rate: 36337.2),
   RealTimeOrder(amount: 0.01423, currencyVs: "USDT", currency: "BTC", rate: 36337.3),
   RealTimeOrder(amount: 0.01223, currencyVs: "USDT", currency: "BTC", rate: 36348.4),
   RealTimeOrder(amount: 0.1277, currencyVs: "USDT", currency: "BTC", rate: 36320.5),
   RealTimeOrder(amount: 0.02441, currencyVs: "USDT", currency: "BTC", rate: 36339.2),
   RealTimeOrder(amount: 0.02421, currencyVs: "USDT", currency: "BTC", rate: 36331.1),
   RealTimeOrder(amount: 0.04342, currencyVs: "USDT", currency: "BTC", rate: 36335.9),
   RealTimeOrder(amount: 0.01242, currencyVs: "USDT", currency: "BTC", rate: 36337.6),

]

    private let coinServices = CoinDataService.shared
    private var cancellables = Set<AnyCancellable>()
    private let coreData = CoreDataController.shared
    private let orderCoreData = CoreDataOrderController.shared
    private let apiCaller = APIService.shared

    @Published var chartEntries: [CandleChartDataEntry] = []

    init() {
        addSubscriber()
        orders = orderCoreData.fetchAllEntities()

    }

    func getInfoCoin(id: String) {
        let param = [
            "tickers" : true,
            "market_data" : true,
            "community_data" : true,
            "developer_data" : true,
            "sparkline" : true
        ]
        apiCaller.request(endpoint: "https://api.coingecko.com/api/v3/coins/" + id, parameters: param, method: .get) { (result: Result<CoinInfo, Error>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.priceIn7D = success.marketData?.sparkline7D?.price ?? []
                    self.high24hUSD = success.marketData?.high24H?["usd"] ?? 0
                    self.low24hUSD = success.marketData?.low24H?["usd"] ?? 0
                    self.ratioCurrency = "\(success.marketData?.low24H?["usd"] ?? 0)"
                    self.chartEntries = self.updateChartEntry(coin: success)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.updateRealTimeOrder(coin: success)
                }


            case .failure(let failure):
                print("@@@ failure: \(failure)")
//                self.error = failure
            }

        }
    }

    func updateRealTimeOrder(coin: CoinInfo) {
        dataTransaction = [
            RealTimeOrder(amount: Double(Float.random(in: 0.00001...0.1)), currencyVs: "USDT", currency: coin.symbol?.uppercased() ?? "", rate: Double.random(in: low24hUSD...high24hUSD)),
           RealTimeOrder(amount: Double(Float.random(in: 0.00001...0.1)), currencyVs: "USDT", currency: coin.symbol?.uppercased() ?? "", rate: Double.random(in: low24hUSD...high24hUSD)),
           RealTimeOrder(amount: Double(Float.random(in: 0.00001...0.1)), currencyVs: "USDT", currency: coin.symbol?.uppercased() ?? "", rate: Double.random(in: low24hUSD...high24hUSD)),
           RealTimeOrder(amount: Double(Float.random(in: 0.00001...0.1)), currencyVs: "USDT", currency: coin.symbol?.uppercased() ?? "", rate: Double.random(in: low24hUSD...high24hUSD)),
           RealTimeOrder(amount: Double(Float.random(in: 0.00001...0.1)), currencyVs: "USDT", currency: coin.symbol?.uppercased() ?? "", rate: Double.random(in: low24hUSD...high24hUSD)),
           RealTimeOrder(amount: Double(Float.random(in: 0.00001...0.1)), currencyVs: "USDT", currency: coin.symbol?.uppercased() ?? "", rate: Double.random(in: low24hUSD...high24hUSD)),
           RealTimeOrder(amount: Double(Float.random(in: 0.00001...0.1)), currencyVs: "USDT", currency: coin.symbol?.uppercased() ?? "", rate: Double.random(in: low24hUSD...high24hUSD)),
           RealTimeOrder(amount: Double(Float.random(in: 0.00001...0.1)), currencyVs: "USDT", currency: coin.symbol?.uppercased() ?? "", rate: Double.random(in: low24hUSD...high24hUSD)),

    ]
    }

    func updateChartEntry(coin: CoinInfo) -> [CandleChartDataEntry] {
        return coin.marketData?.sparkline7D?.price?.enumerated().map { id, price in
            var lowPrice = coin.marketData?.low24H?["usd"] ?? 0
            var highPrice = coin.marketData?.high24H?["usd"] ?? 0

            if Bool.random() {
                lowPrice -=  Double(Float.random(in: 0.1000...200.199999))
                highPrice -=  Double(Float.random(in: 0.1000...200.199999))

            } else {
                lowPrice +=  Double(Float.random(in: 0.1000...200.199999))
                highPrice +=  Double(Float.random(in: 0.1000...200.199999))

            }
            return CandleChartDataEntry(x: Double(id), shadowH: highPrice, shadowL: lowPrice, open: lowPrice +  Double(Float.random(in: 0.1000...200.199999)), close: highPrice +  Double(Float.random(in: 0.1000...200.199999)))
//            return CandleStickCoin(name: "\(coin.symbol ?? "N/A")", day: id,
//                                   lowPrice: lowPrice,
//                                   highPrice: highPrice,
//                                   openPrice: lowPrice + Double(Float.random(in: 0.001...0.1)),
//                                   closePrice: highPrice + Double(Float.random(in: 0.001...0.1)))
        } ?? []
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

    func createOrder(order: OrderHolded) {
        if orderCoreData.insert(element: order) {
            orders = orderCoreData.fetchAllEntities()
        }
    }

    func removeOrder(id: String) {
        if orderCoreData.deleteEntity(id: id) {
            orders = orderCoreData.fetchAllEntities()
        }
    }
}
