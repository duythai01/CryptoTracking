//
//  PersonalView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/11/2023.
//

import SwiftUI

struct PersonalView: View {
    let coinsHolded: [Coin]

    @EnvironmentObject var coordinator: Coordinator<AppRouter>

    @State var hideMoney: Bool = true

    var body: some View {
        ZStack{
            Color.theme.mainColor.ignoresSafeArea()
            VStack{
                currenceAssets
                HStack {
                    PersonalPieChart(totalAsset: "1000 USD")
                }
                .frame(height: UIScreen.main.bounds.height / 2.8)
//                VStack(spacing: 6) {
//                    Image("ic_wallet")
//                        .resizable()
//                        .frame(width: 42, height: 42)
//                    Text("Your account has no assets.")
//                        .font(.system(size: 14, weight: .bold))
//                        .foregroundColor(.white.opacity(0.7))
//                    Text("Deposit now to start.")
//                        .font(.system(size: 13, weight: .bold))
//                        .foregroundColor(.white.opacity(0.5))
//                    HStack {
//                        Spacer()
//                    }
//                }
//                .padding(16)
//                .background(
//                    RoundedRectangle(cornerRadius: 12.0)
//                        .foregroundColor(.gray.opacity(0.2))
//                )

                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(coinsHolded) { coin in
                            genCoinChart(coin: coin, vsCurrency: "USD")
                        }
                        Spacer()
                    }
                    .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("Personal"))
    }

    @ViewBuilder
    func genCoinChart(coin: Coin?, vsCurrency: String) -> some View {
        let percent = (coin?.priceChangePercentage24H ?? 0).configPriceChangePercent()
        let priceChange24h = (coin?.priceChange24H ?? 0).formatTwoNumbeAfterDot(minimumFractionDigits: 2, maximumFractionDigits: 6)
        VStack (alignment: .leading){
            Text("\(coin?.symbol?.uppercased() ?? "") / \(vsCurrency)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 8)
                .padding(.leading, 10)

            Text(percent.addPlusOrMinus())
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(percent.checkIsIncrease() ? .green : .red)
                .padding(.leading, 10)

            Text("\(priceChange24h)".addPlusOrMinus())
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.white)
                .padding(.leading, 10)

            PersonalLineChart(entries:
                            Transaction.mapChartDataEntry(price7D: coin?.sparklineIn7D?.price ?? []),
                          chartColor: percent.checkIsIncrease() ? .green : .red)
            .padding(.horizontal, 8)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        .background(RoundedRectangle(cornerRadius: 8)
            .foregroundColor(Color.gray.opacity(0.2))
            )
    }
}

extension PersonalView {
    var currenceAssets: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                HStack{
                    Text("Total Assets Value")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))
                    Image(systemName: hideMoney ? "eye.slash.circle.fill" : "eye.circle.fill")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white.opacity(0.8))
                        .onTapGesture {
                            hideMoney.toggle()
                        }
                }
                Spacer()

                Button(action: {
                    coordinator.show(.kyc, isNavigationBarHidden: false)
                }, label: {
                    HStack {
                        Image(systemName: "person.badge.shield.checkmark.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white.opacity(0.8))
                        Text("KYC")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.all, 6)
                })
                .background(Color.white.opacity(0.2)
                    .cornerRadius(4))
            }
            HStack(alignment: .center) {
                Text(hideMoney ? "******": "0.00")
                    .font(Font(UIFont(name: "HelveticaNeue-Medium", size: 36)! as CTFont))
                    .foregroundColor(.white) +
                Text(hideMoney ? "" : " USD")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white) +
                Text(hideMoney ? "" : " ▼")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
            }
            Text(hideMoney ? "******" : "≈0.000000 BTC")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white.opacity(0.5))
            HStack {
                Text("Today's PNL")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.7))
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
                Text(hideMoney ? "*******" : "+0.12 USD(+0.01%)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(
                        hideMoney ? .white.opacity(0.6) : ("+0.12".checkIsIncrease() ? .green : .red)
                    )
                    .padding(.leading, 12)
                Spacer()
            }
            .padding(.vertical, 16)
        }
    }

}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView(coinsHolded: DeveloperPreview.shared.holdCoins)
    }
}
