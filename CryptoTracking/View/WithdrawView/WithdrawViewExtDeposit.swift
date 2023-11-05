//
//  WithdrawViewExtDeposit.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/11/2023.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

extension WithdrawView {
    var depositView: some View {
        VStack(alignment: .leading, spacing: 16) {

            //Coin
            VStack(alignment: .leading, spacing: 8) {
                Text("Coin")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                Button(action: {
                    showBottomSheet(type: .depositCoin)
                    isShowChangeBottomView = true
                }, label: {
                    HStack{
                        WebImage(url: URL(string: depositeCoin?.image ?? ""))
                            .resizable()
                            .frame(width: 26, height: 26)

                        Text(depositeCoin?.name ?? "N/A")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical,8)
                })
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(.white.opacity(0.5), lineWidth: 1))
            }

            //Network
            VStack(alignment: .leading, spacing: 8){
                Text("Network")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)

                Button(action: {
                    showBottomSheet(type: .depositNetwork)
                    isShowChangeBottomView = true
                }, label: {
                    HStack{
                        Text(depositNetworkName)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical,8)
                })
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(.white.opacity(0.5), lineWidth: 1))
        }

            // Address
            VStack(alignment: .center, spacing: 20){
                HStack {
                    Text("Address")
                        .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    Spacer()
                }

                Image(uiImage: genenrateQRCode(from: "\(depositeCoin?.id ?? "N/A")-\(depositeCoin?.name ?? "N/A")-\(depositNetworkName)-0x0c1968cd2Ff3Eb0Dc2bEe3ED4679035789ecc720"))
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                HStack {
                    Text("0x0c1968cd2Ff3Eb0Dc2bEe3ED4679035789ecc720")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(.none)
                    Image(systemName: "rectangle.on.rectangle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white.opacity(0.8))
                        .frame(width: 20, height: 20)
                }
                .padding(16)
                .background(Color.gray.opacity(0.1).cornerRadius(12))

        }

            //iformation deposit
            VStack(spacing: 16) {
                HStack {
                    Text("Minimum deposit amount")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white.opacity(0.6))
                    Spacer()
                    Text("0.0000001 USD")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)

                }

                HStack {
                    Text("Deposit arrival")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white.opacity(0.6))
                    Spacer()
                    Text("15 confirmation")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)

                }

                HStack {
                    Text("Contract information")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white.opacity(0.5))
                    Spacer()
                    Text("**01f17E")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)

                }

            }
            .padding(16)
            .background(Color.gray.opacity(0.1).cornerRadius(12))
            .redacted(reason: isLoadInformDeposit ? [] : .placeholder)

            //button
            Spacer()
            HStack {
                Button(action: {}, label: {
                    HStack {
                        Spacer()
                        Text("Save")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.blue)
                            .padding(.vertical, 16)

                        Spacer()
                   }
                })
                .background(
                    Color.gray.opacity(0.2).cornerRadius(8)
                )
                Spacer()
                Button(action: {}, label: {
                    HStack {
                        Spacer()
                        Text("Share")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.white)
                            .padding(.vertical, 16)

                        Spacer()
                   }
                })
                .background(
                    Color.blue.cornerRadius(8)
                )
            }

        }

    }
}
