//
//  HomeView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var coordinator: Coordinator<AppRouter>

    @State var categoryAnimations: [Bool] = Array(repeating: false, count: HomeCategory.allCases.count)
    @State var mockCoinData = [1, 2]
    @State var isNavigate: Bool = false
    @State var destinationView: AnyView = AnyView(BuyView())
    @State  var selectedTabBanner: Int = 0
    let advertismentBanner = ["banner1", "banner2", "banner3", "banner4"]
    let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.theme.mainColor.ignoresSafeArea()
                VStack(spacing: 16) {
                    headerView.padding(.horizontal, 16)
                    balanceAndNews
                    categoryListView.padding(.horizontal, 16)
                        .fixedSize(horizontal: false, vertical: true)
                    MyAssetsView(coins: $mockCoinData)
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                    Spacer()
                }
                .padding(.top, 8)
            }
        }

    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


