//
//  HomeView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    @State var categoryAnimations: [Bool] = Array(repeating: false, count: HomeCategory.allCases.count)
    @State var mockCoinData = [1, 2]
    @State var isNavigate: Bool = false
    @State var destinationView = BuyView()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                            Color.theme.mainColor.ignoresSafeArea()
                            VStack {
                                HomeHeaderView().padding(.horizontal, 16)
                                CreditCardView()
                                categoryListView.padding(.horizontal, 16)
                                    .fixedSize(horizontal: false, vertical: true)
                                MyAssetsView(coins: $mockCoinData)
                                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                                Spacer()
                            }
                        }
                        .background(
                            NavigationLink("", destination: destinationView, isActive: $isNavigate).opacity(0))
                        .onAppear {
                            isNavigate = false
                    }
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


