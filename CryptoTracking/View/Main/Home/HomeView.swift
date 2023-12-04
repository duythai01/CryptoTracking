//
//  HomeView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var coordinator: Coordinator<AppRouter>

    @State var categoryAnimations: [Bool] = Array(repeating: false, count: HomeCategory.allCases.count)
    @State var mockCoinData = [1, 2]
    @State var isNavigate: Bool = false
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
                    VStack {
                        HStack {
                            Text("My Assets")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold))
                            Spacer()
                        }
                        .padding(.leading, 16)
                        listCoinView


                    }
                    .padding(.horizontal, 8)
                    Spacer()
                }
                .padding(.top, 8)
            }
            .onAppear {
                viewModel.getListCoinsInfo()
            }

        }

    }


    private var listCoinView: some View {
        VStack {
            if !viewModel.allCoinsDisplay.isEmpty {
                VStack {
                    Spacer()
                    Image("ic-bitcoin_stack")
                        .resizable()
                        .frame(width: 80, height: 70)
                        .scaledToFit()
                    Text("Your list tracking is empty, discover and add more")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.white.opacity(0.6))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 26)
                        .padding(.top, 8)
                    Spacer()
                }
            } else {
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(DeveloperPreview.shared.coins5) { coin in
                            HStack(alignment: .center) {
                                Text("\(coin.marketCapRank ?? 1)")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(minWidth: 16, alignment: .center)
                                WebImage(url: URL(string: coin.image ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 38, height: 38)
                                GeometryReader { geometryReader in
                                    VStack(alignment: .leading) {
                                        HStack(alignment: .center){
                                            VStack(alignment: .leading){
                                                Text(coin.name ?? "")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 12, weight: .bold))
                                                Spacer()
                                                Text(coin.symbol?.uppercased() ?? "")
                                                    .foregroundColor(.gray)
                                                    .font(.system(size: 12, weight: .bold))
                                            }
                                            .frame(maxWidth: geometryReader.size.width / 3, alignment: .leading)
                                            Spacer()

                                            VStack(alignment: .trailing){
                                                Text( coin.currentHoldingsValue.asCurrencyWithSixDecimals())
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 12, weight: .bold))
                                                Spacer()
                                                Text(String("\(coin.currentHoldings ?? 0)"))
                                                    .foregroundColor(Color.white.opacity(0.5))
                                                    .font(.system(size:  12, weight: .bold))
                                            }
                                            Spacer()
                                            VStack(alignment: .trailing){
                                                Text(String(coin.currentPrice ))
                                                    .foregroundColor(Color.white.opacity(0.5))
                                                    .font(.system(size:  12, weight: .bold))

                                                Spacer()
                                                HStack{
                                                    Text( configPriceChangePercent(percent: coin.priceChangePercentage24H))
                                                        .foregroundColor(configPriceChangePercent(percent: coin.priceChangePercentage24H).checkIsIncrease() ? .green : .red)
                                                        .font(.system(size: 12, weight: .bold))
                                                }
                                            }
                                            .frame(maxWidth: geometryReader.size.width / 3, alignment: .trailing)
                                        }
                                        Spacer()
                                        Color.gray.frame(height: 1 / UIScreen.main.scale)

                                    }
                                }
                            }
                            .frame(width: nil)
                            .listRowBackground(Color.theme.mainColor)
                            .listRowInsets(EdgeInsets())
                            .padding(.all, 8)
                            .onTapGesture {
                                coordinator.show(.coinDetail(id: coin.id ?? "", currency: coin.symbol ?? "btc"), isNavigationBarHidden: false)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(.horizontal, 8)

    }

    func configPriceChangePercent(percent: Double?) -> String {
        guard let percent = percent else { return "0"}

        return percent >= 0 ? "+\(percent)%" : "\(percent)%"
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


