//
//  SwiftUIView.swift
//  CryptoTracking
//
//  Created by DuyThai on 25/10/2023.
//

import SwiftUI
import UIKit

struct WithdrawView: View {
    @State var isBuySelection: Bool = true


    init() {
        // Customize the UINavigationBar appearance
        let appearance = UINavigationBarAppearance()
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
//        appearance.buttonAppearance.normal
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 26, weight: .bold)] // Set the text
        UINavigationBar.appearance().standardAppearance = appearance
    }

    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            VStack {
                switchButton
                currenceAssets
                Spacer()
            }
            .padding(.horizontal, 16)

        }
        .navigationTitle(Text("Withdraw"))
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

extension WithdrawView {
    var switchButton: some View {
        GeometryReader { geometryH in
                HStack {
                    HStack {
                        Image(systemName: "line.diagonal.arrow")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(isBuySelection ? .white : .purple)

                        Text("Buy")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(isBuySelection ? .white : .purple)
                    }
                    .frame(width: geometryH.size.width / 2 - 6)
                    .padding(.vertical, 16)
                    .onTapGesture {
                        withAnimation() {
                            isBuySelection = true
                        }
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "line.diagonal.arrow")
                            .font(.system(size: 18, weight: .bold))
                            .rotationEffect(Angle(degrees: 90))
                            .foregroundColor(isBuySelection ? .purple : .white)

                        Text("Sell")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(isBuySelection ? .purple : .white)
                    }
                    .frame(width: geometryH.size.width / 2 - 6)
                    .padding(.vertical, 16)
                    .onTapGesture {
                        withAnimation() {
                            isBuySelection = false
                        }
                    }
                }
                .frame(width: .infinity)
                .background(
                    Color.white.opacity(0.2)
                        .cornerRadius(12)
                        .background(HStack{
                            if !isBuySelection {
                                Spacer()
                            }
                            Color.purple
                                .frame(width: geometryH.size.width / 2 - 6)
                               .cornerRadius(6)
                               .padding(.all, 5)
                            if isBuySelection {
                                Spacer()
                            }
                        })
            )
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 42)
    }

    var currenceAssets: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack{
                HStack{
                    Text("Total Assets Value")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))
                    Image(systemName: "eye.circle.fill")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white.opacity(0.8))
                }
                Spacer()

                Button(action: {}, label: {
                    HStack {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white.opacity(0.8))
                        Text("Analysis")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.all, 6)
                })
                .background(Color.white.opacity(0.2)
                    .cornerRadius(4))
           }
            HStack(alignment: .center) {
                Text("0.00")
                    .font(Font(UIFont(name: "HelveticaNeue-Medium", size: 36)! as CTFont))
                    .foregroundColor(.white) +
                Text(" USD")
                    .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white) +
                Text(" ▼")
                    .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white)
            }
            Text("≈0.000000 BTC")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white.opacity(0.5))
            HStack {
                Text("Today's PNL")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.7))
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
                Text("+0.12 USD(+0.01%)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor("+0.12".checkIsIncrease() ? .green : .red)
                    .padding(.leading, 16)

                Spacer()
            }
            .padding(.vertical, 16)
        }
        .padding(.top, 48)
    }
}

struct WithdrawView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawView()
    }
}
