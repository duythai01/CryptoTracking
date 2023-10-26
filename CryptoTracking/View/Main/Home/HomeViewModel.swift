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

    private var cancellables = Set<AnyCancellable>()

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

}
