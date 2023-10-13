//
//  CoinCard.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct CoinCard: View {
    let imageCoinUrl: String
    let nameCoin: String
    let symbol: String
    let moneyAmount: String
    let status: String
    let isHistory: Bool
    var body: some View {
        HStack(alignment: .center) {
//            WebImage(url: URL(string: imageCoinUrl))
                Text("1")
                .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .frame(minWidth: 20)
            Image("ic_bitcoin")
                .resizable()
                .scaledToFit()
                .frame(width: 42, height: 42)
            VStack{
                Spacer()
                HStack{
                    Text(nameCoin)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                    Spacer()
                    HStack{
                        Text(moneyAmount)
                            .foregroundColor( isHistory ? (checkIsIncrease(moneyAmount) ? .green : .red) :  .white)
                            .font(.system(size: 14, weight: .bold))
                    }
                }
                Spacer()
                HStack{
                    Text(symbol)
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .bold))
                    Spacer(minLength: 14)
                    HStack{
                        Text(status)
                            .foregroundColor(isHistory ? Color.white.opacity(0.5) : .green)
                            .font(.system(size: isHistory ? 13 : 14, weight: .bold))
                    }
                }
                Spacer()
                Color.gray.frame(height: 1 / UIScreen.main.scale)

            }
        }
        .frame(width: nil)
        .listRowBackground(Color.theme.mainColor)
        .listRowInsets(EdgeInsets())
        .padding(.all, 8)
    }

    func checkIsIncrease(_ text: String) -> Bool {
        return text.prefix(1) == "+"
    }
}

