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
                                self.destinationView = AnyView(BuyView())
                            case .exchange:
                                self.destinationView = AnyView(BuyView())
                            case .receive:
                                self.destinationView = AnyView(BuyView())
                            case .withdraw:
                                self.destinationView = AnyView(WithdrawView())
                            case .send:
                                self.destinationView = AnyView(BuyView())
                            }
                            isNavigate = true
                            withAnimation(.easeOut(duration: 0.1)) {
                                categoryAnimations[index] = true
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.easeIn(duration: 0.1)) {
                                    categoryAnimations[index] = false
                                }
                            }
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

