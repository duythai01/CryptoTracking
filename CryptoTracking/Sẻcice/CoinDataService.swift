//
//  CoinDataService.swift
//  CryptoTracking
//
//  Created by DuyThai on 22/10/2023.
//

import Foundation

//typealias CoinMarket = [Coin]
class CoinDataService {
    @Published var allCoins:[Coin] = []
    @Published var error: Error?


    private let apiCaller = APIService .shared

    static let shared = CoinDataService()

    private init() {
    }
    

    func getCoin(param: CoinMarketParam) {
        apiCaller.requestArray(endpoint: .coinMarket, parameters: param.toDict() , method: .get) {  (result: Result<[Coin], Error>) in
            switch result {
            case .success(let success):
                self.allCoins = success
            case .failure(let failure):
                self.error = failure
            }

        }
    }
}
