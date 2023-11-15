//
//  MarketViewModel.swift
//  CryptoTracking
//
//  Created by DuyThai on 10/11/2023.
//

import Foundation
import SwiftUI
import Combine

class MarketViewModel: ObservableObject {
    @Published var assetPlatform: [AssetPlatformElement] = []
    @Published var assetPlatformDisplay: [AssetPlatformElement] = []
    @Published var searchText: String = ""
    @Published var isHiddenLoading: Bool = false
    @Published var error: Error?

    private let coreDataController = CoreDataController.shared
    private var cancellables = Set<AnyCancellable>()
    private let apiCaller = APIService .shared
    private let imgs = ["BNB Smart Chain", "Arbitrum One", "Ethereum", "Avalanche", "Optimism", "Solana", "Polygon POS", "Klaytn"]
    private let links = ["https://www.bnbchain.org/en/smartChain",
                         "https://arbitrum.io/",
                         "https://ethereum.org/en/",
                         "https://www.avax.network/",
                         "https://www.optimism.io/apps/all",
                         "https://solana.com/",
                         "https://polygon.technology/polygon-pos",
                         "https://klaytn.foundation/ecosystem/"]

    init() {
        addSubscriber()
    }

    private func addSubscriber() {
        $searchText
            .combineLatest($assetPlatformDisplay)
            .map { (text, startingCoins) -> [AssetPlatformElement] in
                if text == ""  {
                    return self.assetPlatform
                }
                let lowercasedText = text.lowercased()
                return startingCoins.filter { platform -> Bool in
                    return platform.name?.lowercased().contains(lowercasedText) ?? false ||
                    platform.shortname?.lowercased().contains(lowercasedText) ?? false ||
                    platform.id.lowercased().contains(lowercasedText) 
                }
            }
            .sink { [weak self] resultSearch in
                self?.assetPlatformDisplay = resultSearch
            }
            .store(in: &cancellables)
    }

    func getAssetPlatForm() {
        let param = AssetPlatformParam(filter: "nft").toDict()
        apiCaller.request(endpoint: .assetPlatform, parameters: param, method: .get) { (result: Result<AssetPlatform, Error>) in
            switch result {
            case .success(let success):
                print(success)
                self.generateAssetWithImg (success: success, imgs: self.imgs, links: self.links)

            case .failure(let failure):
                self.error = failure
            }

        }
            
        }

//    func getAssetPlatForm() {
//        let param = AssetPlatformParam(filter: "nft").toDict()
//        apiCaller.request(endpoint: .assetPlatform, parameters: param, method: .get)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    self.error = error
//                    break
//                }
//            },
//              receiveValue: { [weak self] (response: AssetPlatform) in
//                print(response)
//                self?.assetPlatform = response
//            })
//            .store(in: &cancellables)
//    }

    private func generateAssetWithImg(success: [AssetPlatformElement], imgs: [String], links: [String]) {
        var assetWithImg: [AssetPlatformElement] = []

        for element in success {
            if let index = imgs.firstIndex(of: element.name ?? "") {
                assetWithImg.append(
                    AssetPlatformElement(
                        id: element.id,
                        chainIdentifier: element.chainIdentifier,
                        name: element.name,
                        shortname: element.shortname,
                        img: imgs[index],
                        url: links[index]
                    )
                )
            }
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.assetPlatformDisplay = assetWithImg
            self.assetPlatform = assetWithImg
            self.isHiddenLoading = true
        }
    }

}

