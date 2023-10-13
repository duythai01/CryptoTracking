//
//  BuyView.swift
//  CryptoTracking
//
//  Created by DuyThai on 13/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

enum CategoryBuy: CaseIterable {
    case hot
    case spot
    case futures
    case gainners
    case earn
    case setting

    var name: String {
        switch self {
        case .hot:
            return "Hot"
        case .spot:
            return "Spot"
        case .futures:
            return "Futures"
        case .gainners:
            return "Gainer"
        case .earn:
            return "Earn"
        case .setting:
            return "Setting"
        }
    }
}

struct BuyView: View {
    let coin: Coin

    @State private var searchQuerry = ""
    @State private var showSearchField = false
    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            VStack{
                HStack {
                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: "qrcode")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 28, height: 28)
                        }
                    })
                    Spacer()
                    Text("Shop")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        withAnimation() {
                            showSearchField.toggle()
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 28, height: 28)
                        }
                    })
                }
                .padding(.horizontal, 16)
                if showSearchField {
                    SearchField(searchQuery: $searchQuerry)
                        .padding(.vertical, 16)
                }

                    HStack{
                        ForEach(0..<6, id: \.self) { index in
                            Text("Spot")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding(8)
                                .background(
                                    LinearGradient(colors: [Color.purple, Color.white.opacity(0), Color.white.opacity(0)], startPoint: .bottom, endPoint: .top)
                                )

                        }
                        .padding(.vertical, 8)
                    }

                VStack {
                    CoinCard(imageCoinUrl:coin.image ?? "" ,
                             nameCoin: coin.name ?? "",
                             symbol: coin.symbol ?? "",
                             moneyAmount: String(coin.currentPrice ?? 0), status: configPriceChangePercent(percent: coin.priceChangePercentage24H), isHistory: false)
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 8)
                Spacer()
            }
        }


    }

    func configPriceChangePercent(percent: Double?) -> String {
        guard let percent = percent else { return "0"}

        return percent >= 0 ? "+\(percent)" : "-\(percent)"
    }
}

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView(coin: self.dev.coin  )
    }
}
