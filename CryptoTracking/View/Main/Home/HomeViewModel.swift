//
//  HomeViewModel.swift
//  CryptoTracking
//
//  Created by DuyThai on 23/10/2023.
//

import Foundation
import SwiftUI
import Combine
class HomeViewModel: ObservableObject {
    @Published var toDestination: HomeCategory?
    @Published var isNavigate: Bool = false
    @Published var allCoins: [Coin] = []
    @Published var allCoinsDisplay: [Coin] = []
    private var cancellables = Set<AnyCancellable>()
    private let apiCaller = APIService.shared
    private let coreData = CoreDataController.shared

    init() {
        addSubscriber()
    }

    private func addSubscriber() {

        $toDestination
            .sink(receiveValue: { [weak self] category in
                if (category?.rawValue == nil){
                        DispatchQueue.main.async {
                            self?.isNavigate  = false
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.isNavigate = true
                        }
                    }
            })
            .store(in: &cancellables)

    }


    func getListCoinsInfo() {
        print("@@@@ corelist: \(getIdSFromCoreData())")
        let ids = formatString()
        var  param: [String : Any] =  ["vs_currency" : "usd",
                          "ids" : ids,
                          "order" : "market_cap_desc",
                          "per_page" : 100,
                          "page" : 1,
                          "sparkline" : true,
                          "price_change_percentage" : "1h",
                          "locale" : "en",
                          "precision" : 6
                         ]
        print("@@@@parma: \(param)")
        if getIdSFromCoreData().count > 0 {
            apiCaller.requestArray(endpoint: "https://api.coingecko.com/api/v3/coins/markets", parameters: param, method: .get) {  (result: Result<[Coin], Error>) in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else {return}
                        self.allCoins = success
                        self.allCoinsDisplay = success
                    }
                    print("@@@Success: \(success)")
                case .failure(let failure):
                    print("Failuerd")
                }

            }
        }
    }

    func formatString() -> String {
        let array = getIdSFromCoreData()
        var ids: String = ""
        for (index, id) in array.enumerated() {
             if index == array.count - 1 {
                 ids += id
             } else {
                 if index % 2 == 0 {
                     ids += "\(id)%2c%20"
                 } else {
                     ids += "\(id)%2c"
                 }
             }
         }
        return ids
    }

    func getIdSFromCoreData() -> [String] {
        return coreData.fetchAllEntities().map { $0.id }
    }

}
