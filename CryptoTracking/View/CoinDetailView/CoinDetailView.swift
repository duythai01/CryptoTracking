//
//  CoinDetailView.swift
//  CryptoTracking
//
//  Created by DuyThai on 15/11/2023.
//

import SwiftUI
import Charts

enum DetailInfoType: CaseIterable {
    case openOrder
    case trade
    case asset
    case strategy

    var name: String {
        switch self {
        case .openOrder:
            return "Open Orders"
        case .trade:
            return "Trades"
        case .asset:
            return "Assets"
        case .strategy:
            return "Strategy"
        }
    }

    var type: [String] {
        switch self {
        case .openOrder:
            return ["Limit/Market", "Conditional", "Time Condition"]
        case .trade:
            return ["My Trades", "All Trades"]
        case .asset:
            return []
        case .strategy:
            return ["Recommendations", "Most Profitable", "Most copied", "Return", "Follow's Funding", "Profits for Copy Trader"]
        }
    }
}

struct CoinDetailView: View {
    let coinID: String

    @State var isDisplayChart: Bool = false
    @State var isUp: Bool = true
    @State var isBuy: Bool = true
    @State var isCurrentMarket: Bool = false
    @State private var sliderValuePercent: Double = 0.0 //{
//        didSet {
//            if let doubleValue = Decimal(string: amount), let bal = Decimal(string: balance) {
//                let inCrease = (NSDecimalNumber(decimal: doubleValue).doubleValue * sliderValuePercent * NSDecimalNumber(decimal: bal).doubleValue)
//                amount = "\(inCrease)"
//            }
//        }
//    }
    @State var typeDetail: DetailInfoType = .trade
    @State private var transactionInforHeight: CGFloat = 0.0
    @State var detailInfoType: (DetailInfoType, String) = (.trade, "All Trades")
    @State var amount: String = "0"
    @State var ratioCurrency: String = "37400"
    @State var balance: String = "3.960000"
    @State var total: String = "0"


    @StateObject var viewModel = CoinViewModel()


    var randomValue: Double { sliderValuePercent > 50 ? Double.random(in: 10...35) : Double.random(in: 55...90) }
    let highValue = 100.0
    let dataTransaction: [RealTimeOrder] = [
        RealTimeOrder(amount: 0.1234, currencyVs: "USDT", currency: "BTC", rate: 36337.2),
        RealTimeOrder(amount: 0.01423, currencyVs: "USDT", currency: "BTC", rate: 36337.3),
        RealTimeOrder(amount: 0.01223, currencyVs: "USDT", currency: "BTC", rate: 36348.4),
        RealTimeOrder(amount: 0.1277, currencyVs: "USDT", currency: "BTC", rate: 36320.5),
        RealTimeOrder(amount: 0.02441, currencyVs: "USDT", currency: "BTC", rate: 36339.2),
        RealTimeOrder(amount: 0.02421, currencyVs: "USDT", currency: "BTC", rate: 36331.1),
        RealTimeOrder(amount: 0.04342, currencyVs: "USDT", currency: "BTC", rate: 36335.9),
        RealTimeOrder(amount: 0.01242, currencyVs: "USDT", currency: "BTC", rate: 36337.6),

    ]

    @State var dataAllTrade: [RealTimeAllTrade] = []


    var body: some View {
        ZStack{
            Color.theme.mainColor.ignoresSafeArea()
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                    headerView

                    if isDisplayChart {
                        CoinCandleStickChart(entries: CandleStickCoin.entryies.map {
                            CandleChartDataEntry(x: Double($0.day), shadowH: $0.highPrice, shadowL: $0.lowPrice, open: $0.openPrice, close: $0.closePrice)
                        }, chartColor: .blue)
                        .frame(height: UIScreen.main.bounds.height / 4)
                    }
                    //Transaction
                    HStack(alignment: .top) {
                        tableTransactionView
                            .frame(maxWidth: geometry.size.width / 2 - 16)
                        Spacer()
                        buildTransactionInfoView(geometry: geometry)
                    }

                    //List orders
                    VStack(spacing: 8) {
                        HStack {
                            ForEach(DetailInfoType.allCases, id: \.self) { type in
                                Text(type.name)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(typeDetail == type ? .white : .gray)
                                    .onTapGesture {
                                        withAnimation {
                                            typeDetail = type
                                        }
                                    }
                            }
                            Spacer()
                        }
                        Color.white.opacity(0.1).frame(height: 2)
                        buildDetailInfo()
                            .padding(.bottom, 12)
                    }
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.85)
                    .padding(.top, 8)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .navigationTitle(Text(coinID.uppercased()))
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
        .onAppear{
            amount = "\((NSDecimalNumber(decimal: Decimal(string: amount) ?? 0).doubleValue * sliderValuePercent * NSDecimalNumber(decimal: Decimal(string: balance) ?? 0).doubleValue))"

            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                // Update the counter every second
                let latestTrade = RealTimeAllTrade(price: Double.random(in: 36466.7...36479.7),
                                                   vsCurrency: "USDT",
                                                   currency: "BTC",
                                                   amount: Double.random(in: 0.000001...1.00000),
                                                   isBuy: Bool.random())
                if Bool.random() {
                    dataAllTrade.insert(latestTrade, at: 0)

                  if let lastTimestamp = dataAllTrade.last?.time,
                 Int(latestTrade.time.timeIntervalSince(lastTimestamp)) > 59 {
                   dataAllTrade.removeLast()
               }

                }
                }
        }
    }
}

extension CoinDetailView {
    var headerView: some View {
        HStack {
            Text("BTC / USDT")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            Text("+2.873%")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.green)
                .padding(.all, 4)
                .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.green.opacity(0.2)))
            Spacer()

            HStack(spacing: 12){
                Button(action: { isDisplayChart.toggle() }, label: {
                    HStack(alignment: .bottom, spacing: 3) {
                        Image(systemName: "chart.bar.xaxis")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white.opacity(isDisplayChart ? 1 : 0.5))
                        Image(systemName: "play.fill")
                            .font(.system(size: 8, weight: .bold))
                            .foregroundColor(.white.opacity(isDisplayChart ? 1 : 0.5))
                            .rotationEffect(Angle(degrees: isDisplayChart ? 90 : -90))
                            .padding(.bottom, 4)
                    }
                })

                Button(action: {  }, label: {
                    HStack(alignment: .bottom, spacing: 4) {
                        Image(systemName: "distribute.horizontal.center.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white.opacity(0.5))
                    }
                })

            }
        }
    }

    var tableTransactionView: some View {
        VStack {
            HStack{
                Text("Price\n(\("USDT"))")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white.opacity(0.7))
                Spacer()
                Text("Amount\n(\("BTC"))")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white.opacity(0.7))
            }
            buildBuySellAmountView(isSell: true)
                .padding(.top, 8)

            Button(action: {}, label: {
                HStack {
                    VStack(alignment: .leading){
                        HStack(spacing: 6) {
                            Text("36355.9")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(isUp ? .green : .red)
                            Image(systemName: "play.fill")
                                .font(.system(size: 8, weight: .bold))
                                .foregroundColor(isUp ? .green : .red)
                                .rotationEffect(Angle(degrees:isUp ? -90 : 90))

                        }
                        Text("≈36300.2")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white.opacity(0.6))
                }
            })
            .padding(.vertical, 8)

            buildBuySellAmountView(isSell: false)

        }
    }

    var filterOrder: some View {
        HStack{
            HStack(spacing: 4) {
                Text("Price")
                    .foregroundColor(.white.opacity((viewModel.filterType == .rank(statusFilter: .down) || viewModel.filterType == .rank(statusFilter: .up)) ? 1 : 0.6))
                    .font(.system(size: 13, weight: .bold))

                VStack(spacing: 2) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .resizable()
                        .frame(width: 5, height: 5)
                        .foregroundColor(viewModel.filterType == .rank(statusFilter: .up) ? .yellow : .gray)

                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 5, height: 5)
                        .foregroundColor(viewModel.filterType == .rank(statusFilter: .down) ? .yellow : .gray)
                }
            }.onTapGesture {
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

            Spacer()

            HStack(spacing: 4) {
                Text("Time")
                    .foregroundColor(.white.opacity((viewModel.filterType == .holding(statusFilter: .up) || viewModel.filterType == .holding(statusFilter: .down))  ? 1 : 0.6))
                    .font(.system(size: 13, weight: .bold))
                VStack(spacing: 2) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .resizable()
                        .frame(width: 5, height: 5)
                        .foregroundColor( viewModel.filterType == .holding(statusFilter: .up) ? .yellow : .gray)

                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 5, height: 5)
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

            HStack(spacing: 4) {
                Text("Amount")
                    .foregroundColor(.white.opacity((viewModel.filterType == .price(statusFilter: .down) || viewModel.filterType == .price(statusFilter: .up)) ? 1 : 0.6))
                    .font(.system(size: 13, weight: .bold))
                VStack(spacing: 2) {
                    Image(systemName: "arrowtriangle.up.fill")
                        .resizable()
                        .frame(width: 5, height: 5)
                        .foregroundColor(viewModel.filterType == .price(statusFilter: .up)  ? .yellow : .gray)

                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 5, height: 5)
                        .foregroundColor(viewModel.filterType == .price(statusFilter: .down)  ? .yellow : .gray)
                }
            }
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

}

extension CoinDetailView {
    
    @ViewBuilder
    func buildTransactionInfoView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 8) {
            //Switch button
            HStack {
               Text("Buy")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white.opacity(isBuy ? 1 : 0.6))
                    .frame(width: geometry.size.width / 4.2)
                .onTapGesture {
                    withAnimation {
                        isBuy = true
                    }
                }
                Spacer()
                Text("Sell")
                     .font(.system(size: 15, weight: .bold))
                     .foregroundColor(.white.opacity(isBuy ? 0.6 : 1))
                     .frame(width: geometry.size.width / 4.2)
                 .onTapGesture {
                     withAnimation {
                         isBuy = false
                     }
                 }
            }
            .padding(.vertical, 4)
            .background(
                HStack {
                    if !isBuy {
                        Spacer()
                    }
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(isBuy ? .green : .red)
                        .frame(width: geometry.size.width / 4.2)
                    if isBuy {
                        Spacer()
                    }
                }
            )

            // Available
            HStack {
                Text("Available")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white.opacity(0.6))
                Spacer()
                Text("\(balance) USDT")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)

            }

            //Transaction type
            HStack {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.leading, 8)

                Spacer()
                Text("Limit")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "play.fill")
                    .font(.system(size: 10))
                    .rotationEffect(Angle(degrees: 90))
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
            .padding(.vertical, 6)
            .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.white.opacity(0.1)))
            .padding(.top, 6)

            VStack(alignment: .leading, spacing: 2) {
                HStack{Spacer()}
                HStack {
                    Text("-")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                        .onTapGesture {
                            if let doubleValue = Decimal(string: ratioCurrency) {
                                ratioCurrency = "\(doubleValue >= 0.1 ? doubleValue - 0.1 : 0)"
                                let updateTotal: String = (NSDecimalNumber(decimal: doubleValue >= 0.1 ? doubleValue - 0.1 : 0).doubleValue * (Double(amount) ?? 0)).formatTwoNumbeAfterDot(minimumFractionDigits: 0)
                                total = updateTotal
                            }

                        }

                    Spacer()
                    TextField("", text: $ratioCurrency)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
//                    Text("37400")
//                        .font(.system(size: 16, weight: .bold))
//                        .foregroundColor(.white)
                    Spacer()
                    Text("+")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                        .onTapGesture {
                            if let doubleValue = Decimal(string: ratioCurrency) {
                                ratioCurrency = "\(doubleValue + 0.1)"
                                let updateTotal: String = (NSDecimalNumber(decimal: doubleValue + 0.1).doubleValue * (Double(amount) ?? 0)).formatTwoNumbeAfterDot(minimumFractionDigits: 0)
                                total = updateTotal
                            }
                        }
                }
                .padding(.vertical, 6)
                .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.white.opacity(0.1)))

                Text("≈36300.2")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white.opacity(0.6))

                HStack {
                    Text("-")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                        .onTapGesture {
                            if let doubleValue = Decimal(string: amount) {
                                amount = "\(doubleValue >= 0.1 ? doubleValue - 0.1 : 0)"
                                let updateTotal: String = (NSDecimalNumber(decimal: doubleValue >= 0.1 ? doubleValue - 0.1 : 0).doubleValue * (Double(ratioCurrency) ?? 0)).formatTwoNumbeAfterDot(minimumFractionDigits: 0)
                                total = updateTotal
                            }
                        }

                    Spacer()
                    TextField("", text: $amount)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                        .keyboardType(.decimalPad)
                    Spacer()
                    Text("+")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                    .onTapGesture {
                        if let doubleValue = Decimal(string: amount) {
                            let inCrease = doubleValue + 0.1
                            amount = "\(inCrease)"
                            let updateTotal: String = (NSDecimalNumber(decimal: inCrease).doubleValue * (Double(ratioCurrency) ?? 0)).formatTwoNumbeAfterDot(minimumFractionDigits: 0)
                            total = updateTotal
                        }
                    }
                }
                .padding(.vertical, 6)
                .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.white.opacity(0.1)))
                .padding(.top, 8)
            }
            .padding(.top, 8)

            CustomSliderView(steppedSlider: false,
                             progressColor: .white.opacity(0.4),
                             customSliderHeight: 12,
                             customSliderWidth: 12,
                             customSlider: Circle()
                                            .stroke(lineWidth: 3)
                                            .foregroundColor(.purple)
                                            .background(Circle().foregroundColor(.theme.mainColor)),
                             percentProgress: $sliderValuePercent)


            HStack {
                Spacer()
                Text(total)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                Spacer()

            }
            .padding(.vertical, 6)
            .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.white.opacity(0.1)))
            .padding(.top, 16)
            HStack {
                Spacer()
                Text(isBuy ? "Buy BTC" : "Sell BTC")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                Spacer()

            }
            .padding(.vertical, 6)
            .background(RoundedRectangle(cornerRadius: 6).foregroundColor(isBuy ? .green.opacity(0.8) : .red.opacity(0.8)))
            .padding(.top, 16)
        }
        .frame(maxWidth: geometry.size.width / 2 - 16)

    }

    @ViewBuilder
    func buildBuySellAmountView(isSell: Bool) -> some View {
        VStack {
            ForEach(dataTransaction, id: \.self) { data in
                let randomValue = Double.random(in: 0.0...1.0)
                HStack {
                    Text("\(data.rate.formatTwoNumbeAfterDot(maximumFractionDigits: 1))")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(isSell ? .red : .green )
                        .lineLimit(1)
                    Spacer()
                    Text("\(data.amount.formatTwoNumbeAfterDot(minimumFractionDigits: 1, maximumFractionDigits: 6))")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: (UIScreen.main.bounds.size.width  / 3.7), alignment: .trailing)
                        .background(
                            HStack {
                                Spacer()
                                if isSell {
                                    Color.red.opacity(0.16)
                                        .frame(width: (UIScreen.main.bounds.size.width / 3.7) * randomValue)
                                } else {
                                    Color.green.opacity(0.16)
                                        .frame(width: (UIScreen.main.bounds.size.width / 3.7) * randomValue)
                                }
                            }
                        )

                }
            }
        }

    }

    @ViewBuilder
    func buildDetailInfo() -> some View {
        VStack {
            if !typeDetail.type.isEmpty {
                VStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(typeDetail.type, id: \.self) { text in
                                Text(text)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.white.opacity(0.7))
                                    .padding(.all, 4)
                                    .background(RoundedRectangle(cornerRadius: 4).foregroundColor(
                                        detailInfoType == (typeDetail, text) ? .purple.opacity(0.4) :
                                                .white.opacity(0.1))
                                    )
                                    .onTapGesture {
                                            detailInfoType = (typeDetail, text)
                                    }
                            }
                        }
                    }

                }
            }

            switch typeDetail {
            case .openOrder:
                VStack{
                    HStack {
                        HStack{
                            Circle()
                                .stroke(lineWidth: isCurrentMarket ? 5 : 2)
                                .foregroundColor(isCurrentMarket ? .purple : .white.opacity(0.5))
                                .frame(width: 12, height: 12)
                            Text("Current Market")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(isCurrentMarket ? .purple : .white.opacity(0.5))
                        }
                        .padding(.leading, 8)
                        .onTapGesture {
                            isCurrentMarket.toggle()
                        }
                        Spacer()
                        Text("Cancel All")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(.white.opacity(0.1)))
                    }

                    //Filter
                    filterOrder

                    //Order list
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(0..<6, id: \.self) { id in
                                buildOrderBill()
                            }
                        }
                    }
                }
            case .trade:
                
                if detailInfoType.1 ==  "My Trades" {
                    VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                ForEach(0..<6, id: \.self) { id in
                                    buildMyTradeItem()
                                }
                            }
                        }
                    }
                } else {
                    VStack {
                        HStack {
                            Text("Time")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white.opacity(0.6))
                            Spacer()
                            Text("Price(USDT)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white.opacity(0.6))
                            Spacer()
                            Text("Amount(BTC)")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white.opacity(0.6))
                        }
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(dataAllTrade) { trade in
                                    HStack(alignment: .center, spacing: 0) {
                                        HStack {
                                            Text(trade.time.formatDateTo(type: "HH:mm:ss"))
                                                .font(.system(size: 13, weight: .bold))
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                        .frame(width: (UIScreen.main.bounds.width - 42) / 3 )

                                        HStack {
                                            VStack(spacing: 2) {
                                                Text(trade.price.formatTwoNumbeAfterDot(minimumFractionDigits: 1))
                                                    .font(.system(size: 15, weight: .bold))
                                                    .foregroundColor(trade.isBuy ? .green : .red)
                                                Text("≈36,300.2 USD")
                                                    .font(.system(size: 12, weight: .bold))
                                                    .foregroundColor(.white.opacity(0.3))
                                            }

                                            Spacer()

                                        }
                                        .frame(width: (UIScreen.main.bounds.width - 20) / 3 )
                                        Spacer()
                                        VStack(spacing: 2) {
                                            HStack {
                                                Spacer()
                                                Text(trade.amount.formatTwoNumbeAfterDot(minimumFractionDigits: 1) )
                                                    .font(.system(size: 13, weight: .bold))
                                                .foregroundColor(.white)
                                            }
                                            HStack {
                                                Spacer()
                                                Text(trade.valueVs.formatTwoNumbeAfterDot(minimumFractionDigits: 1) + " USD")
                                                    .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(.white.opacity(0.3))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            case .asset:
                EmptyView()
            case .strategy:
                EmptyView()
            }


        }
        .padding(.top, 8)
    }

    @ViewBuilder
    func buildOrderBill() -> some View {
        VStack {
            HStack {
                Text("BTC/USD")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)

                Text("Buy")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.green)
                    .padding(.all, 2)
                    .background(RoundedRectangle(cornerRadius: 2).foregroundColor(.green.opacity(0.1)))
                Spacer()
                Text("Cancel")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.red))
            }

            HStack {
                Text(Date().formatDateTo(type: "yyyy-MM-dd HH:mm:ss"))
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white.opacity(0.6))
                Spacer()
            }

            //progress
            GeometryReader { geo in
                VStack {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.white.opacity(0.2))
                        .frame(height: 6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.red)
                            .frame(height: 6)
                            .padding(.trailing, geo.size.width * 0.2)
                    )
                    HStack{
                        Spacer()
                        Text("80 %")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.all, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 4).foregroundColor(.red.opacity(0.7)))
                            .padding(.trailing, geo.size.width * 0.2)
                    }
                }

            }
            .frame(height: 32)

            HStack{
                VStack(alignment: .leading, spacing: 6){
                    Text("Price(USDT)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                    Text("30255 / 36255.9")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 6){
                    Text("Amount(BTC)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                    Text("0.00015 / 0.0002")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .padding(.all, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.theme.mainColor)
                .shadow(color: .white.opacity(0.2), radius: 2, x: 0, y: 4)

        )
        .padding(.horizontal, 8)
    }

    @ViewBuilder
    func buildMyTradeItem() -> some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("BTC/USD")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)

                    Text("Buy")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.green)
                        .padding(.all, 2)
                        .background(RoundedRectangle(cornerRadius: 2).foregroundColor(.green.opacity(0.1)))
                    Spacer()
                }
                Text(Date().formatDateTo(type: "yyyy-MM-dd HH:mm:ss"))
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white.opacity(0.4))
            }

            HStack{
                Text("Role/Order ID")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white.opacity(0.4))
                Spacer()

                Text("maker/6659356310")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
            }

            HStack{
                Text("Price (USDT)")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white.opacity(0.4))
                Spacer()

                Text("36255.9")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
            }

            HStack{
                Text("Filled amount (BTC)")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white.opacity(0.4))
                Spacer()

                Text("0.00003")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
            }

            HStack{
                Text("Total (USFT)")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white.opacity(0.4))
                Spacer()

                Text("1.087677")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
            }

            HStack{
                Text("Free (Point)")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white.opacity(0.4))
                Spacer()

                Text("0.002175")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
            }

            Color.white.opacity(0.4)
                .frame(height: 2)

        }
        .padding(.horizontal, 8)
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(coinID: "bitcoin")
    }
}

struct RealTimeOrder: Hashable {
    let amount: Double
    let currencyVs: String
    let currency: String
    let rate: Double

    var valueVs: Double {
        return amount * rate
    }

    // Implement Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(amount)
        hasher.combine(currencyVs)
        hasher.combine(currency)
        hasher.combine(rate)
    }
}

extension Date {
    func formatDateTo(type: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }
}

struct RealTimeAllTrade: Identifiable {
    let id = UUID().uuidString
    let time = Date()
    let price: Double
    let vsCurrency: String
    let currency: String
    let amount: Double
    let isBuy: Bool
    var valueVs: Double {
        return amount * price
    }
}
