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
                                coordinator.navigationController.isNavigationBarHidden = false
                                coordinator.show(.buy)
                            case .exchange:
                                coordinator.navigationController.isNavigationBarHidden = false
                                coordinator.show(.exchange)
                            case .receive:
                                coordinator.navigationController.isNavigationBarHidden = false
                                coordinator.show(.receive)
                            case .withdraw:
                                coordinator.navigationController.isNavigationBarHidden = false
                                coordinator.show(.withdraw)
                            case .send:
                                coordinator.navigationController.isNavigationBarHidden = false
                                coordinator.show(.send)
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

