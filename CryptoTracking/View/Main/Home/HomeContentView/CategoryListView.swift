//
//  CategoryListView.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation
import SwiftUI

struct CategoryListView: View {
    @State private var animations: [Bool] = Array(repeating: false, count: HomeCategory.allCases.count)

    var body: some View {
        VStack {
            HStack {
                Text("Category")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Text("See more")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .medium))
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 25) {
                    ForEach(HomeCategory.allCases.indices, id: \.self) { index in
                        let category = HomeCategory.allCases[index]
                        let isAnimating = animations[index]

                        VStack(alignment: .center) {

                            Circle()
                                .frame(width: isAnimating ? 60 : 45, height: isAnimating ? 60 : 45)
                                .foregroundColor(.purpleView)
                                .overlay(
                                    category.image
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.all, 16)
                                        .foregroundColor(Color.white))
                                .onTapGesture(){
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        animations[index] = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        withAnimation(.easeIn(duration: 0.2)) {
                                            animations[index] = false
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
                    }
                }

            }
        }
    }
}

