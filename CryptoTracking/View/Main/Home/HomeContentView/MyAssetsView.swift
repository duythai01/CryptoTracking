//
//  MyAssetsView.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation
import SwiftUI

struct MyAssetsView: View {
    @Binding var coins: [Int]
    var body: some View {
        VStack {
            HStack {
                Text("My Assets")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }
            .padding(.leading, 16)
            List {
                ForEach(coins, id:\.self) { coin in
                    CoinCard(imageCoinUrl: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", nameCoin: "BitCoin", symbol: "BTC", moneyAmount: "$ 12312.22", status: "+ 2.32%", isHistory: false)
                }

            }
            .listStyle(.plain)


        }
        .padding(.horizontal, 8)
    }
}
