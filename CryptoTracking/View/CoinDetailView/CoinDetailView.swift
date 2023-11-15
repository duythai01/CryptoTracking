//
//  CoinDetailView.swift
//  CryptoTracking
//
//  Created by DuyThai on 15/11/2023.
//

import SwiftUI

struct CoinDetailView: View {
    @State var isDisplayChart: Bool = false

    let dataTransaction: [RealTimeOrder] = [
        RealTimeOrder(amount: 0.1234, currencyVs: "USDT", currency: "BTC", rate: 36337.2),
        RealTimeOrder(amount: 0.01423, currencyVs: "USDT", currency: "BTC", rate: 36337.3),
        RealTimeOrder(amount: 0.01223, currencyVs: "USDT", currency: "BTC", rate: 36348.4),
        RealTimeOrder(amount: 0.1277, currencyVs: "USDT", currency: "BTC", rate: 36320.5),
        RealTimeOrder(amount: 0.02441, currencyVs: "USDT", currency: "BTC", rate: 36339.2),
        RealTimeOrder(amount: 0.02421, currencyVs: "USDT", currency: "BTC", rate: 36331.1),
        RealTimeOrder(amount: 0.04342, currencyVs: "USDT", currency: "BTC", rate: 36335.9),
        RealTimeOrder(amount: 0.01242, currencyVs: "USDT", currency: "BTC", rate: 36337.6),
        RealTimeOrder(amount: 0.003443, currencyVs: "USDT", currency: "BTC", rate: 36337.2),

    ]
    var body: some View {
        ZStack{
            Color.theme.mainColor.ignoresSafeArea()
            VStack{
                headerView
                GeometryReader { geometry in
                    HStack {
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

                            Button(action: {}, label: {
                                HStack {
                                    VStack{
                                        HStack {
                                            Text("36355.9")
                                                .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.green)
                                        }
                                    }
                                }
                            })
                        }
                            .frame(maxWidth: geometry.size.width / 2)
                        VStack {}
                            .frame(maxWidth: geometry.size.width / 2)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 10)
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
                            .foregroundColor(.white.opacity(isDisplayChart ? 1 : 0.5))
                    }
                })

            }
        }

    }
}

extension CoinDetailView {
    @ViewBuilder
    func buildBuySellAmountView(isSell: Bool) -> some View {
        VStack {
            ForEach(dataTransaction, id: \.self) { data in
                let randomValue = Double.random(in: 0.0...1.0)
                HStack {
                    Text("\(data.valueVs.formatTwoNumbeAfterDot(maximumFractionDigits: 1))")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(isSell ? .red : .green )
                    Spacer()
                    Text("\(data.amount.formatTwoNumbeAfterDot(minimumFractionDigits: 1, maximumFractionDigits: 6))")
                        .font(.system(size: 13, weight: .semibold))
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
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView()
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
