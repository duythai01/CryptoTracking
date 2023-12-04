//
//  CreditCardView.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation
import SwiftUI

extension HomeView {

    var balanceAndNews: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Portfolio")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.yellow)
                    Spacer()
                    Text("")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.yellow)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)

                VStack(spacing: 4) {
                    Text("$10,231.91")
                        .font(.title2)
                        .foregroundColor(.white)
                    HStack(spacing: 5) {
                        Text("+0.87")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.green)
                        Color.white.frame(width: 3 / UIScreen.main.scale)
                            .padding(.vertical, 3)

                        Text("1.53%")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.green)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 12)

                HStack {
                    Text("Last 24h")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.all, 4)
                        .background(
                            Color.gray
                                .opacity(0.5)
                            .cornerRadius(6))
                    Spacer()
                    Text("15 minutes ago")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 16)

            }
            .frame(height: UIScreen.main.bounds.size.height / 5.8)

            .background(
                Color.black)
            .cornerRadius(16)
            .shadow( color: .purple ,radius: 3)

            Spacer()
            VStack() {
                ZStack {
                    TabView(selection: $selectedTabBanner) {
                        ForEach(0..<advertismentBanner.count, id: \.self) { index in
                            HStack {
                                Image(advertismentBanner[index])
                                    .resizable()
                            }
                            .tag(index)
                        }

                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .onReceive(timer) { _ in
                        selectedTabBanner = (selectedTabBanner + 1) % advertismentBanner.count
                    }
                .overlay(Color.black.opacity(0.6))
                    VStack(alignment: .leading, spacing: 6){
                        Spacer()
                        Text("Binance Announces Exit from Canada, Citing Regulatory Binance Announces Exit from Canada, Citing Regulatory")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .padding(.horizontal, 8)
                        Text("2 minutes ago")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 16)

                    }
                }
                .onTapGesture {
                    coordinator.show(.newsView, isNavigationBarHidden: false)
                }
                }
            .frame(height: UIScreen.main.bounds.size.height / 5.8)

            .background(
                Color.black)
            .cornerRadius(16)
            .shadow( color: .purple ,radius: 3)

        }

        .padding(.horizontal, 16)

    }
}


//            VStack(spacing: 0) {
//                HStack {
//                    Text("CURRENT BALANCE")
//                        .font(.system(size: 20, weight: .thin))
//                        .foregroundColor(.white)
//                    Spacer()
//                }
//                .padding(.horizontal, 16)
//                .padding(.top, 12)
//                HStack {
//                    Text("$ 9999.99")
//                        .font(.system(size: 28, weight: .bold))
//                        .foregroundColor(.white)
//                    Spacer()
//                }.padding(.horizontal, 16)
//                    .padding(.top, 6)
//
//                Spacer(minLength: 12)
//                GeometryReader { geometry in
//                    HStack {
//                        Text("0x111CecD9618D45Cb0f94fdb4801D01c91bBAF0Ba")
//                            .font(.system(size: 14, weight: .medium))
//                            .frame(width: geometry.size.width / 1.8)
//                            .lineLimit(1)
//                            .truncationMode(.middle)
//                            .foregroundColor(.white)
//
//                        Image(systemName: "rectangle.on.rectangle")
//                            .resizable()
//                            .scaledToFit()
//                            .foregroundColor(.white)
//                            .frame(width: 20, height: 20)
//                        Spacer()
//                    }
//                }.padding(.horizontal, 16)
//            }
//            Image("icon_money_bag")
//                .resizable()
//                .scaledToFill()
//                .frame(width: 80, height: 80)
//            Spacer()
