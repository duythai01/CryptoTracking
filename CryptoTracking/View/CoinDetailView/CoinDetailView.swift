//
//  CoinDetailView.swift
//  CryptoTracking
//
//  Created by DuyThai on 15/11/2023.
//

import SwiftUI
import Charts

struct CoinDetailView: View {
    let coinID: String
    let currency: String
    @State var isDisplayChart: Bool = false
    @State var isUp: Bool = true
    @State var isBuy: Bool = true
    @State var isCurrentMarket: Bool = false
    @State var typeDetail: DetailInfoType = .openOrder
    @State private var transactionInforHeight: CGFloat = 0.0
    @State var detailInfoType: (DetailInfoType, String) = (.openOrder, "Limit/Market")
    @State var total: String = "0"
    @State var bottomSheetMode: BottomSheetViewMode = .none
    @State var dataAllTrade: [RealTimeAllTrade] = []
    @State var orderType: String = "Limit"
    @State var noticeText: String = ""
    @State var displayNoticeText: Bool = false
    @State private var opacityNoticeText: Double = 1.0
    @StateObject var viewModel = CoinViewModel()


    var randomValue: Double { viewModel.sliderValuePercent > 50 ? Double.random(in: 10...35) : Double.random(in: 55...90) }
    let highValue = 100.0

 
    let orderTypes = ["Limit", "Market", "Conditional", "Time Condition"]

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

//                            CoinCandleStickChart(entries: viewModel.chartEntries, chartColor: .blue)
//                            .frame(height: UIScreen.main.bounds.height / 4)
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

            //Modal layer
            if bottomSheetMode != .none {
                Color.black.opacity(0.4).ignoresSafeArea()
                    .onTapGesture {
                        bottomSheetMode = .none
                    }
            }

            //BottomSheetView
            BottomSheetView(mode: $bottomSheetMode) {
                ZStack {
                    Color(#colorLiteral(red: 0.1598833799, green: 0.1648724079, blue: 0.2934403419, alpha: 1))
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                    VStack {

                        VStack(spacing: 8) {
                            ForEach(orderTypes, id: \.self) { type in
                                HStack {
                                    Spacer()
                                    Text(type)
                                        .font(.system(size: 18, weight:  .bold))
                                        .foregroundColor(.white.opacity(orderType == type ?  1 : 0.7))
                                        .padding(.vertical, 8)
                                    Spacer()
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .foregroundColor( Color.purple.opacity(orderType == type ? 0.6 : 0)
                                    )
                                )
                                .onTapGesture {
                                    orderType = type
                                }
                            }
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 16)

                        Spacer()
                      Button(action: {
                          bottomSheetMode = .none

                      }, label: {
                          HStack {
                              Spacer()
                              Text("Cancel")
                                  .font(.system(size: 18, weight:  .bold))
                                  .foregroundColor(.white)
                                  .padding(.vertical, 8)
                              Spacer()
                          }
                      })
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .foregroundColor( Color.red.opacity(0.7)
                            )
                        )
                        .padding(.bottom, 24)
                        .padding(.horizontal, 16)



                    }
                    .padding(.horizontal, 16)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            if noticeText != "" {
                Text(noticeText)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.purpleView))
                    .opacity(opacityNoticeText)
                    .transition(.opacity.animation(.easeInOut(duration: 1)))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeIn(duration: 1.2)) {
                                opacityNoticeText = 0.0
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                                noticeText = ""
                                opacityNoticeText = 1.0 // Reset opacity for the next appearance
                            }

                        }
                    }
            }

        }
        .navigationTitle(Text(coinID.uppercased()))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)

        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
        .onAppear{
            viewModel.getInfoCoin(id: coinID)
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                // Update the counter every second
                let latestTrade = RealTimeAllTrade(price: Double.random(in: viewModel.low24hUSD...viewModel.high24hUSD),
                                                   vsCurrency: "USDT",
                                                   currency: "BTC",
                                                   amount: Double(Float.random(in: 0.000001...1.00000)),
                                                   isBuy: Bool.random())
                if Bool.random() {
                    dataAllTrade.insert(latestTrade, at: 0)

                    if let lastTimestamp = dataAllTrade.last?.time,
                       Int(latestTrade.time.timeIntervalSince(lastTimestamp)) > 59 {
                        dataAllTrade.removeLast()
                    }

                }
            }
            viewModel.checkIsEixstCoreData(coinID: coinID)
        }
    }
}

// View element
extension CoinDetailView {
    func configPriceChangePercent(percent: Double?) -> String {
        guard let percent = percent else { return "0"}

        return percent >= 0 ? "+\(percent)%" : "\(percent)%"
    }
    var headerView: some View {
        HStack {
            Text("\(currency.uppercased()) / USDT")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            Text( configPriceChangePercent(percent: viewModel.priceChange1hPercent))

                .font(.system(size: 14, weight: .bold))
                .foregroundColor(configPriceChangePercent(percent: viewModel.priceChange1hPercent).checkIsIncrease() ? .green : .red)
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

                Button(action: {
                    viewModel.switchSaveToCoreDate(coinID: coinID)
                }, label: {
                    HStack(alignment: .bottom, spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(
                                viewModel.isStar ? .yellow : .white.opacity(0.5))
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
                            Text(((viewModel.high24hUSD + viewModel.low24hUSD) / 2).formatTwoNumbeAfterDot(maximumFractionDigits: 1))
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

//Func viewbuilder
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
                        .frame(width: geometry.size.width / 4.2 - 8)
                        .padding(.horizontal, 8)
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
                Text("\(viewModel.balance) USDT")
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
                Text(orderType)
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
            .onTapGesture {
                bottomSheetMode = .half
            }


            if orderType == "Time Condition" {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Trigger Interval")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white.opacity(0.7))
                    HStack {
                        Spacer()
                        TextField("", text: $viewModel.amount)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                            .keyboardType(.decimalPad)
                        Spacer()
                        Text("Min(s)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.trailing, 8)
                    }
                    .padding(.vertical, 6)
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.white.opacity(0.1)))
                .padding(.top, 8)
                }
                .padding(.top, 8)
            }

            VStack(alignment: .leading, spacing: 2) {
                HStack{Spacer()}

                if true {
                    HStack {
                        Text("-")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                            .onTapGesture {
                                if let doubleValue = Decimal(string: viewModel.ratioCurrency) {
                                    viewModel.ratioCurrency = "\(doubleValue >= 0.1 ? doubleValue - 0.1 : 0)"
                                    let updateTotal: String = (NSDecimalNumber(decimal: doubleValue >= 0.1 ? doubleValue - 0.1 : 0).doubleValue * (Double(viewModel.amount) ?? 0)).formatTwoNumbeAfterDot(minimumFractionDigits: 0)
                                    total = updateTotal
                                }

                            }

                        Spacer()
                        TextField("", text: $viewModel.ratioCurrency)
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
                                if let doubleValue = Decimal(string: viewModel.ratioCurrency) {
                                    viewModel.ratioCurrency = "\(doubleValue + 0.1)"
                                    let updateTotal: String = (NSDecimalNumber(decimal: doubleValue + 0.1).doubleValue * (Double(viewModel.amount) ?? 0)).formatTwoNumbeAfterDot(minimumFractionDigits: 0)
                                    total = updateTotal
                                }
                            }
                    }
                    .padding(.vertical, 6)
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.white.opacity(0.1)))

                    Text("≈36300.2")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
                }

                HStack {
                    Text("-")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                        .onTapGesture {
                            if let doubleValue = Decimal(string: viewModel.amount) {
                                viewModel.amount = "\(doubleValue >= 0.00001 ? doubleValue - 0.00001 : 0)"
                                let updateTotal: String = (NSDecimalNumber(decimal: doubleValue >= 0.00001 ? doubleValue - 0.00001 : 0).doubleValue * (Double(viewModel.ratioCurrency) ?? 0)).formatTwoNumbeAfterDot(minimumFractionDigits: 0)
                                total = updateTotal
                            }
                        }

                    Spacer()
                    TextField("", text: $viewModel.amount)
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
                            if let doubleValue = Decimal(string: viewModel.amount) {
                                let inCrease = doubleValue + 0.00001
                                viewModel.amount = "\(inCrease)"
                                let updateTotal: String = (NSDecimalNumber(decimal: inCrease).doubleValue * (Double(viewModel.ratioCurrency) ?? 0)).formatTwoNumbeAfterDot(minimumFractionDigits: 0)
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
                             percentProgress: $viewModel.sliderValuePercent)


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
            Button(action: {
                let order = OrderHolded(id: UUID().uuidString,
                                        rate: Double(viewModel.ratioCurrency) ?? 0,
                                        progress:  Double.random(in: 0.01...1.00),
                                        rateTitle: "\(currency.uppercased())/USDT",
                                        type: isBuy ? "Buy" : "Sell",
                                        createdDate: Date(),
                                        amount: Double(viewModel.amount) ?? 0)
                if (total == "0") {
                    noticeText = "Please enter amount."
                }  else {
                    viewModel.createOrder(order: order)
                }
            }, label:  {
                HStack {
                    Spacer()
                    Text(isBuy ? "Buy \(currency.uppercased())" : "Sell \(currency.uppercased())")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()

                }
                .padding(.vertical, 6)
                .background(RoundedRectangle(cornerRadius: 6).foregroundColor(isBuy ? .green.opacity(0.8) : .red.opacity(0.8)))
            })
            .padding(.top, 16)

        }
        .frame(maxWidth: geometry.size.width / 2 - 16)

    }

    @ViewBuilder
    func buildBuySellAmountView(isSell: Bool) -> some View {
        VStack {
            ForEach(viewModel.dataTransaction, id: \.self) { data in
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
                .onTapGesture {
                    viewModel.ratioCurrency = "\(data.rate )"
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
                            ForEach(viewModel.orders) { order in
                                buildOrderBill(order: order)
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
    func buildOrderBill(order: OrderHolded) -> some View {
        VStack {
            HStack {
                Text(order.rateTitle)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)

                Text(order.type)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(order.type == "Buy" ? .green : .red)
                    .padding(.all, 2)
                    .background(RoundedRectangle(cornerRadius: 2).foregroundColor(order.type == "Buy" ? .green.opacity(0.1) : .red.opacity(0.1)))
                Spacer()
                Text("Cancel")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.red))
                    .onTapGesture {
                        viewModel.removeOrder(id: order.id)
                    }
            }

            HStack {
                Text(order.createdDate.formatDateTo(type: "yyyy-MM-dd HH:mm:ss"))
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
                                .foregroundColor(order.type == "Buy" ? .green : .red)
                                .frame(height: 6)
                                .padding(.trailing, geo.size.width * 0.2)
                        )
                    HStack{
                        Spacer()
                        Text((order.progress * 100).formatTwoNumbeAfterDot(maximumFractionDigits: 2) + "%")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.all, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 4).foregroundColor(order.type == "Buy" ? .green : .red.opacity(0.7)))
                            .padding(.trailing, geo.size.width * (1 - order.progress))
                    }
                }

            }
            .frame(height: 32)

            HStack{
                VStack(alignment: .leading, spacing: 6){
                    Text("Price(USDT)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                    Text((order.rate * order.progress * order.amount).formatTwoNumbeAfterDot(maximumFractionDigits: 2) + " / " + (order.rate * order.amount).formatTwoNumbeAfterDot(maximumFractionDigits: 2))
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 6){
                    Text("Amount(BTC)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white.opacity(0.6))
                    Text((order.progress * order.amount).formatTwoNumbeAfterDot(maximumFractionDigits: 6) + " / " + (order.amount).formatTwoNumbeAfterDot(maximumFractionDigits: 6))
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
        .padding([.horizontal, .bottom], 8)
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
        CoinDetailView(coinID: "bitcoin", currency: "BTC")
    }
}
