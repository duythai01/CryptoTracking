//
//  P2PView.swift
//  CryptoTracking
//
//  Created by DuyThai on 13/11/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct P2PView: View {
    @State var isBuy: Bool = true
    @State var amountWantToChange: String = ""
    @State var onEditingChanged: Bool = false
    @State var buyCoin: Coin? = DeveloperPreview.shared.conins15[0]

    let p2pTypes = [
        P2PType(id: "Merchant", type: ["Blue Vip", "Traded", "My Following"]),
        P2PType(id: "Order Type", type: ["Normal", "Block Trade"]),
        P2PType(id: "Payment Method", type: ["Bank Transfer", "Alipay", "Wechat", "Swift international remittance", "PayPal", "FPS", "Wise", "ShoppeePay", "Cake", "MoMo", "Viettel Pay", "ZaloPay"]),

    ]


    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            VStack {
                headerView
                HStack {
                    HStack {
                        HStack{
                            WebImage(url: URL(string: buyCoin?.image ?? ""))
                                .resizable()
                                .frame(width: 16, height: 16)

                            Text(buyCoin?.name ?? "N/A")
                                .font(.system(size: 12, weight: .medium))
                                .lineLimit(1)
                                .foregroundColor(.white)

                            Image(systemName: "chevron.down")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.leading, 4)
                        }
                        .padding(.vertical, 8)
                        .padding(.trailing, 8)
                        .onTapGesture {

                        }

                        CustomTextField(text: $amountWantToChange, onEditingChanged: $onEditingChanged, placeHolderStr: "Enter amount (\(buyCoin?.symbol ?? "")) ")
                    }
                    .padding(.horizontal, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.white)
                )
                    Spacer()
                    Button(action: {}, label: {
                        Image("ic_filter")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 22, height: 22)
                    })
                    .padding(.leading, 16)
                }




            Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}



// View
extension P2PView {
    var headerView: some View {
        HStack {
            VStack {
                HStack {
                Button(action: {
                    withAnimation {
                        isBuy = true
                    }
                }, label: {
                        Text("Buy")
                            .font(.system(size: 18, weight: .bold))
                        .foregroundColor(isBuy ? .purple : .gray)

                })
                .padding(.all, 8)


                Button(action: {
                    withAnimation {
                        isBuy = false
                    }
                }, label: {
                        Text("Sell")
                            .font(.system(size: 18, weight: .bold))
                        .foregroundColor(!isBuy ? .purple : .gray)

                })
                .padding(.all, 8)

                Spacer()
                }
                GeometryReader { geometry in
                    HStack {
                        if !isBuy { Spacer() }

                        Color.purple.frame(width: geometry.size.width / 2, height: 4)
                        if isBuy { Spacer() }
                    }
                }
            }
            .fixedSize(horizontal: true, vertical: true)
            Spacer()


            Button(action: {}, label: {
                HStack {
                    Text("VND")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white.opacity(0.7))
                    Image(systemName: "arrow.right.arrow.left")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white.opacity(0.7))
                }
            })
            .padding(.all, 8)
            .background(RoundedRectangle(cornerRadius: 6)
                .foregroundColor(.white.opacity(0.3)))
        }
    }
}

struct P2PView_Previews: PreviewProvider {
    static var previews: some View {
        P2PView()
    }
}

struct P2PType: Identifiable {
    let id: String
    let type: [String]
}
