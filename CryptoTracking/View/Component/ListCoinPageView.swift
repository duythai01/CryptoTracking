//
//  ListCoinView.swift
//  CryptoTracking
//
//  Created by DuyThai on 09/10/2023.
//

import Foundation
import SwiftUI

struct ListCoinPageView: View {
    @Binding var selectedTab: Int
    let transactionsSend: [Int] = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
    let transactionsReceive: [Int] = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5]

    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                List {
                    ForEach(transactionsSend, id:\.self) { transactionsSend in
                        CoinCard(imageCoinUrl: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", nameCoin: "0.004 BTC", symbol: "Bitcoin", moneyAmount: (transactionsSend.isMultiple(of: 2) ? "+" : "-") + "$ 5,432.002", status: "2023/09/06, 9:07 AM", isHistory: true, showIndex: false)
                    }

                }
                .listStyle(.plain)


            }
            .padding(.horizontal, 8).tag(1)
            VStack {
                List {
                    ForEach(transactionsSend, id:\.self) { transactionsSend in
                        CoinCard(imageCoinUrl: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", nameCoin: "0.004 BTC", symbol: "Bitcoin", moneyAmount: "-$ 5,432.002", status: "2023/09/06, 9:07 AM", isHistory: true, showIndex: false)
                    }

                }
                .listStyle(.plain)
            }
            .padding(.horizontal, 8).tag(2)
            VStack {
                List {
                    ForEach(transactionsSend, id:\.self) { transactionsSend in
                        CoinCard(imageCoinUrl: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", nameCoin: "0.009 BTC", symbol: "Bitcoin", moneyAmount: "+$ 5,432.002", status: "2023/09/06, 9:07 AM", isHistory: true, showIndex: false)
                    }

                }
                .listStyle(.plain)


            }
            .padding(.horizontal, 8).tag(3)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

