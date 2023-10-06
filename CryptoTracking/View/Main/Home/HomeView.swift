//
//  HomeView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var animate: Bool = true

    @State var mockCoinData = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.mainColor.ignoresSafeArea()
                VStack {
                    HomeHeaderView().padding(.horizontal, 16)
                    CreditCardView()
                    CategoryListView().padding(.horizontal, 16)
                        .fixedSize(horizontal: false, vertical: true)
                    MyAssetsView(coins: $mockCoinData)
                    Spacer()
                    Text("Header").foregroundColor(.white)
                    Spacer()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
