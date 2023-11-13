//
//  CategoryListView.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation
import SwiftUI

extension HomeView {
    var categoryListView: some View {
        HStack{
            ForEach(HomeCategory.allCases.indices, id: \.self) { index in
                let category = HomeCategory.allCases[index]
                let isAnimating = categoryAnimations[index]
                Spacer()
                VStack(alignment: .center) {

                    Circle()
                        .frame(width: isAnimating ? 58 : 42, height: isAnimating ? 58 : 42)
                        .foregroundColor(.purpleView)
                        .overlay(
                            category.image
                                .resizable()
                                .scaledToFit()
                                .padding(.all, 13)
                                .foregroundColor(Color.white))
                        .onTapGesture(){
                            switch category {
                            case .buy:
                                coordinator.show(.buy, isNavigationBarHidden: false)
                            case .exchange:
                                coordinator.show(.exchange, isNavigationBarHidden: false)
                            case .receive:
                                coordinator.show(.receive, isNavigationBarHidden: false)
                            case .withdraw:
                                coordinator.show(.withdraw, isNavigationBarHidden: false)
                            case .p2p:
                                coordinator.show(.send, isNavigationBarHidden: false)
                            }
                                categoryAnimations[index] = true
                                categoryAnimations[index] = false
                        }
                        .background(
                            Circle()
                                .opacity(isAnimating ? 1 : 0)
                                .foregroundColor(.white)
                                .frame(width: isAnimating ? 65 : 50, height: isAnimating ? 65 : 50))

                    Text(category.displayName)
                        .font(.system(size: 13))
                        .foregroundColor(.white)

                }.padding(.vertical, 8)
                Spacer()
            }

        }
    }
}

