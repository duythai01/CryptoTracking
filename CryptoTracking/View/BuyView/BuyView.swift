//
//  BuyView.swift
//  CryptoTracking
//
//  Created by DuyThai on 13/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

enum CategoryBuy: CaseIterable {
    case spot
    case futures
    case gainners
    case earn
    case new

    var name: String {
        switch self {
        case .spot:
            return "Spot"
        case .futures:
            return "Futures"
        case .gainners:
            return "Gainer"
        case .earn:
            return "Earn"
        case .new:
            return "New"
        }
    }
}

enum CoinDefault: CaseIterable {
    case usdt
    case usdts
    case btc
    case eth
    case etf
    case new
    case zone

    var name: String {
        switch self {
        case .usdt:
            return "USDT"
        case .usdts:
            return "USDT©"
        case .btc:
            return "BTC"
        case .eth:
            return "ETH"
        case .etf:
            return "ETF"
        case .new:
            return "New"
        case .zone:
            return "Zones"
        }
    }
}

enum StatusFilter {
    case up
    case down
    case off
}

struct BuyView: View {
//    let coin: Coin
    @StateObject private var viewModel = BuyViewModel()
    @State private var searchQuerry = ""
    @State private var showSearchField = false
    @State private var categoryBuySelected: CategoryBuy  = .spot
    @State private var coinDefaultSelected: CoinDefault  = .usdt


    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            VStack(spacing: 16){
                HStack {
                    Spacer()
                    Text("Shop")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        withAnimation() {
                            showSearchField.toggle()
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "qrcode")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                        }
                    })
                }
                .padding(.horizontal, 16)
                // Banner
                RotationBanner()

                SearchField(searchQuery:  $viewModel.searchText, placeHolder: "Enter name coin")
                    .padding(.top, 16)

                categoryBuy
                lisCoinView
                Spacer()
            }
        }
        .onAppear {
//            viewModel.filterType = .rank(statusFilter: .up)
            viewModel.showLoadingCoins = true
        }


    }

    func configPriceChangePercent(percent: Double?) -> String {
        guard let percent = percent else { return "0"}

        return percent >= 0 ? "+\(percent)%" : "\(percent)%"
    }
}


extension BuyView {

    private var lisCoinView: some View {

        VStack {
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
                print("@@@: Ranking")
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
                    withAnimation {
                        print("@@@: HOLDING")
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
                    print("@@@: PRICE")
                    withAnimation {
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
                        }
                    }
                    .listStyle(.plain)
                    .fixedSize(horizontal: false, vertical: true)
                }
                if viewModel.showLoadingCoins {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
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
                        withAnimation{
                            coinDefaultSelected = item
                        }
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
                            withAnimation {
                                categoryBuySelected = item
                            }
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

struct RotationBanner: View {
    @State private var selectedTabBanner: Int = 0
    let advertismentBanner = ["banner1", "banner2", "banner3", "banner4"]
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        TabView(selection: $selectedTabBanner) {
            ForEach(0..<advertismentBanner.count, id: \.self) { index in
                HStack {
                    Image(advertismentBanner[index])
                        .resizable()
                        .scaledToFill()
                }
                .tag(index)
            }

        }
        .frame(height: 130)
        .padding(.horizontal, 20)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onReceive(timer) { _ in
            selectedTabBanner = (selectedTabBanner + 1) % advertismentBanner.count
        }
    }
}
