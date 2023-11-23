//
//  BuyView.swift
//  CryptoTracking
//
//  Created by DuyThai on 13/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct BuyView: View {
    @StateObject private var viewModel = BuyViewModel()
    @EnvironmentObject var coordinator: Coordinator<AppRouter>

    @State private var searchQuerry = ""
    @State private var showSearchField = false
    @State private var categoryBuySelected: CategoryBuy  = .spot
    @State private var coinDefaultSelected: CoinDefault  = .usdt

    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            VStack(spacing: 16){
                // Banner
                RotationBanner()

                SearchField(searchQuery:  $viewModel.searchText, placeHolder: "Enter name coin", texSize: 16, iconSize: 20)
                    .padding(.top, 16)

                categoryBuy
                filterCoins

                LoadingView(isHidden: $viewModel.isHiddenLoadCoin, content: listCoinView)

                Spacer()
            }
        }

        .navigationTitle(Text("BUY"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            withAnimation() {
                showSearchField.toggle()
            }
        },
         label: {
            HStack {
                Image(systemName: "qrcode")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 24, height: 24)
            }
        }))
        .edgesIgnoringSafeArea(.bottom)
        .onTapGesture {
            // End editing mode when tapping outside of the text field
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onAppear{
            coordinator.navigationController.navigationItem.backButtonTitle = ""

        }
    }

    func configPriceChangePercent(percent: Double?) -> String {
        guard let percent = percent else { return "0"}

        return percent >= 0 ? "+\(percent)%" : "\(percent)%"
    }
}


extension BuyView {

        private var filterCoins: some View {
            HStack{
                HStack {
                    Text("Ranking")
                        .foregroundColor(.white.opacity((viewModel.filterType == .rank(statusFilter: .down) || viewModel.filterType == .rank(statusFilter: .up)) ? 1 : 0.6))
                        .font(.system(size: 16, weight: .bold))
                        .padding(.leading, 35)

                    VStack(spacing: 2) {
                        Image(systemName: "arrowtriangle.up.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .foregroundColor(viewModel.filterType == .rank(statusFilter: .up) ? .yellow : .gray)

                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .foregroundColor(viewModel.filterType == .rank(statusFilter: .down) ? .yellow : .gray)
                    }
                }.onTapGesture {
                    withAnimation {

                        switch viewModel.filterType {
                        case .rank(let status):
                            switch status {
                            case .up:
                                viewModel.filterType = .rank(statusFilter: .down)
                            case .down:
                                viewModel.filterType = .rank(statusFilter: .off)
                            case .off:
                                viewModel.filterType = .rank(statusFilter: .up)

                            }
                        default:
                            viewModel.filterType = .rank(statusFilter: .up)

                        }
                    }

                }

                Spacer()

                HStack {
                    Text("Holding")
                        .foregroundColor(.white.opacity((viewModel.filterType == .holding(statusFilter: .up) || viewModel.filterType == .holding(statusFilter: .down))  ? 1 : 0.6))
                        .font(.system(size: 16, weight: .bold))
                    VStack(spacing: 2) {
                        Image(systemName: "arrowtriangle.up.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .foregroundColor( viewModel.filterType == .holding(statusFilter: .up) ? .yellow : .gray)

                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .foregroundColor(viewModel.filterType == .holding(statusFilter: .down) ? .yellow : .gray)
                    }
                }
                .onTapGesture {
                        switch viewModel.filterType {
                        case .holding(let status):
                            switch status {
                            case .up:
                                viewModel.filterType = .holding(statusFilter: .off)
                            case .down:
                                viewModel.filterType = .holding(statusFilter: .up)
                            case .off:
                                viewModel.filterType = .holding(statusFilter: .down)
                            }
                        default:
                            viewModel.filterType = .holding(statusFilter: .down)

                        }
                }

                Spacer()

                HStack() {
                    Text("Price")
                        .foregroundColor(.white.opacity((viewModel.filterType == .price(statusFilter: .down) || viewModel.filterType == .price(statusFilter: .up)) ? 1 : 0.6))
                        .font(.system(size: 16, weight: .bold))
                    VStack(spacing: 2) {
                        Image(systemName: "arrowtriangle.up.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .foregroundColor(viewModel.filterType == .price(statusFilter: .up)  ? .yellow : .gray)

                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .foregroundColor(viewModel.filterType == .price(statusFilter: .down)  ? .yellow : .gray)
                    }
                }
                .padding(.trailing, 16)
                .onTapGesture {
                        switch viewModel.filterType {
                        case .price(let status):
                            switch status {
                            case .up:
                                viewModel.filterType = .price(statusFilter: .off)
                            case .down:
                                viewModel.filterType = .price(statusFilter: .up)
                            case .off:
                                viewModel.filterType = .price(statusFilter: .down)
                            }
                        default:
                            viewModel.filterType = .price(statusFilter: .down)
                        }
                    }
            }

        }

        private var listCoinView: some View {
            VStack {
                ZStack(alignment: .center) {
                    ScrollView(.vertical) {
                        LazyVStack {
                            ForEach(viewModel.allCoinsDisplay) { coin in
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
                                    coordinator.show(.coinDetail(id: coin.id ?? ""), isNavigationBarHidden: false)
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

        private var defaultCoinList: some View {
            HStack(spacing: 10){
                ForEach(CoinDefault.allCases, id: \.self) { item in
                    Text(item.name)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .padding(6)
                        .border(Color.white.opacity(0.4), width: 2)
                        .background(
                            VStack {
                                coinDefaultSelected == item ? Color.purple.opacity(0.8) : Color.white.opacity(0.2)
                            })
                        .onTapGesture {
                            coinDefaultSelected = item
                        }
                        .padding(.horizontal, 4)

                }
                .padding(.vertical, 8)
            }
            .frame(alignment: .leading)
        }

        private var categoryBuy: some View {
            HStack(spacing: 8){
                ForEach(CategoryBuy.allCases, id: \.self) { item in
                    Text(item.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            LinearGradient(colors: [item == categoryBuySelected ? Color.purple : Color.white.opacity(0) ,  Color.white.opacity(0), Color.white.opacity(0)], startPoint: .bottom, endPoint: .top)
                                .transition(.scale)
                        )
                        .onTapGesture {
                            categoryBuySelected = item
                        }
                        .padding(.horizontal, 6)

                }
                .padding(.vertical, 8)
            }

        }
    }

struct BuyView_Previews: PreviewProvider {
    static var previews: some View {
        BuyView()
    }
}
