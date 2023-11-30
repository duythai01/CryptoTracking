//
//  ExchangeViewModel.swift
//  CryptoTracking
//
//  Created by DuyThai on 29/11/2023.
//

import Foundation
import SwiftUI
import Combine

class ExchangeViewModel: ObservableObject {

    var rates: [String: Rate] = [:]
    @Published var ratesGetDisplay: [String: Rate] = [:]
    @Published var ratesPayDisplay: [String: Rate] = [:]
    @Published var payAmount: String = "0"
    @Published var getAmount: String = "0"

    @Published var error: Error?

    @Published var payRate: Rate?

    @Published var payRateKey: [String] = []


    @Published var getRate: Rate?
    @Published var getRateKey: [String] = []

    @Published var payVsGetRate: Double = 320

    var isPayAmounEdit = false


    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscriber()
    }

    private func addSubscriber() {
        Publishers.CombineLatest3($payAmount, $getAmount, $payVsGetRate)
            .sink { [weak self] payAmountStr, getAmountStr, valueRate in
                guard let self = self else { return }
                /// 1 payValue == valueRate * getValue
                if let payValue = Decimal(string: (payAmountStr == "" ? "0" : payAmountStr)),
                   let getValue = Decimal(string: (getAmountStr == "" ? "0" : getAmountStr)) {
                    if self.isPayAmounEdit {
                        self.getAmount = (NSDecimalNumber(decimal: payValue).doubleValue / valueRate).formatTwoNumbeAfterDot(minimumFractionDigits: 0,maximumFractionDigits: 6, isGroupSeperator: false)
                    } else {
                        self.payAmount = (NSDecimalNumber(decimal: getValue).doubleValue * valueRate).formatTwoNumbeAfterDot(minimumFractionDigits: 0,maximumFractionDigits: 6, isGroupSeperator: false)
                    }
                }
            }
            .store(in: &cancellables)

        Publishers.CombineLatest($payRate, $getRate)
            .sink { [weak self] payR, getR in
                self?.payVsGetRate = (getR?.value ?? 0) / (payR?.value ?? 1)
            }
            .store(in: &cancellables)
    }

    func getRates() {
        APIService.shared.request(endpoint: .rate,
                                  parameters: [:],
                                  method: .get) { (result: Result<ExchangeRate, Error>) in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.rates = success.rates ?? [:]
                        self.updatRateDisplay(data: success.rates ?? [:])
                    }
                case .failure(let failure):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        print("@@@ erroe: \(failure)")
                        self.error = failure
                    }
                }

            }

    }

    func updatRateDisplay(data: [String: Rate]) {
        ratesGetDisplay =  data.filter { $0.value.type == .fiat}
        ratesPayDisplay =  data.filter { $0.value.type != .fiat}

        payRateKey = ratesPayDisplay.map { $0.key }
        getRateKey = ratesGetDisplay.keys.sorted {
            $0.localizedCaseInsensitiveCompare($1) == .orderedAscending
        }

        getRate = ratesGetDisplay["btc"]
        payRate = ratesPayDisplay["usd"]
    }
}
