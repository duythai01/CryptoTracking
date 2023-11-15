//
//  P2PView.swift
//  CryptoTracking
//
//  Created by DuyThai on 13/11/2023.
//

import SwiftUI
import SDWebImageSwiftUI
enum P2PBottomSheet {
    case flag
    case payment
}

struct P2PView: View {
    @State var isBuy: Bool = true
    @State var amountWantToChange: String = ""
    @State var onEditingChanged: Bool = false
    @State var buyCoin: Coin? = DeveloperPreview.shared.conins15[0]
    @State var showBottomSheetType: WithdrawSheetSelection = .payment
    @State var bottomSheetMode: BottomSheetViewMode = .custom(heightRatio: 0.6)
    @State var searchFiat: String = ""
    @State var merchantType: String = ""
    @State var orderType: String = ""
    @State var paymentMethod: String = ""
    @State var amountTransaction: String = ""
    @State var amountCryptoTransaction: String = ""
    @State var currency: String = "VND"

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
                amountAndFilter
                TabView(selection: $isBuy) {
                    buidListBuyTransaction()
                        .tag(true)
                    buidListSellTransaction()
                        .tag(false)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .padding(.top, 20)

                Spacer()
            }
            .padding(.horizontal, 16)
            if bottomSheetMode != .none {
                Color.black.opacity(0.2).ignoresSafeArea()
                    .onTapGesture {
                        bottomSheetMode = .none
                    }
            }

            // Bottom sheet
            BottomSheetView(mode: $bottomSheetMode) {
                bottomSheet
            }
        }
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
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


            Button(action: {
                showBottomSheet(type: .flag)
            }, label: {
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

    var amountAndFilter: some View {
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
                    showBottomSheet(type: .changeCoin)
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
            Button(action: {
                showBottomSheet(type: .filter)
            }, label: {
                Image("ic_filter")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 22, height: 22)
            })
            .padding(.leading, 16)
        }

    }

    var bottomSheet: some View {
        ZStack {
            Color(#colorLiteral(red: 0.09111639081, green: 0.07618386149, blue: 0.1349048857, alpha: 1))
                .cornerRadius(16, corners: [.topLeft, .topRight])
            VStack {
                HStack {
                    if showBottomSheetType == .payment {
                        HStack {
                            WebImage(url: URL(string: buyCoin?.image ?? ""))
                                .resizable()
                                .frame(width: 26, height: 26)
                            VStack(alignment: .leading) {
                                Text("Buy \(buyCoin?.symbol?.uppercased() ?? "")")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)

                                Text("Unit price \(2461)vnd")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.green)
                            }
                        }
                    } else {
                        Text(showBottomSheetType.sectionTitle)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white.opacity(0.7))
                        .onTapGesture {
                            bottomSheetMode = .none
                        }
                }
                .padding(.vertical, 16)

                buildBodyViewSheet()

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }

    func showBottomSheet(type: WithdrawSheetSelection) {
            showBottomSheetType = type
            switch type {
            case .flag:
                bottomSheetMode = .custom(heightRatio: 0.8)

            case .changeCoin:
                bottomSheetMode = .custom(heightRatio: 0.7)

            case .filter, .payment:
                bottomSheetMode = .custom(heightRatio: 0.6)
            default:
                bottomSheetMode = .none
            }
    }

}

extension P2PView {
    @ViewBuilder
    func buildBodyViewSheet() -> some View {
        switch showBottomSheetType {
        case .flag:
            VStack {
                SearchField(searchQuery: $searchFiat, placeHolder: "Search", texSize: 13, iconSize: 16)
            }
        case .filter:
            VStack {
                VStack {
                    ForEach(p2pTypes) { section in
                        VStack(alignment: .leading) {
                            Text(section.id)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.white)
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()),

                            ],
                              alignment: .leading, spacing: 8) {
                                ForEach(section.type, id: \.self) { text in
                                    Text(text)
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.white.opacity(0.7))
                                        .padding(.all, 6)
                                        .background(RoundedRectangle(cornerRadius: 6)
                                            .foregroundColor(Color.white.opacity(0.2)))
                                        .onTapGesture {
                                            if section.id == "Merchant" {
                                                if merchantType == text {
                                                    merchantType = ""
                                                }
                                                else {
                                                    merchantType = text
                                                }
                                            }
                                            else if section.id  == "Order Type" {

                                            }
                                            else if section.id == "Payment Method" {

                                            }
                                        }
                                }
                            }
                        }
                    }

                    Spacer()
                    HStack {
                        Button(action: {}, label: {
                            HStack {
                                Spacer()
                                Text("Reset")
                                    .font(.system(size: 15, weight: .heavy))
                                    .foregroundColor(.blue)
                                    .padding(.vertical, 12)
                                Spacer()
                           }
                        })
                        .background(
                            Color.gray.opacity(0.2).cornerRadius(8)
                        )
                        Spacer()
                        Button(action: {}, label: {
                            HStack {
                                Spacer()
                                Text("Confirm")
                                    .font(.system(size: 15, weight: .heavy))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 12)

                                Spacer()
                           }
                        })
                        .background(
                            Color.blue.cornerRadius(8)
                        )
                    }
                    .padding(.bottom, 16)

                }
                .padding(.top, 16)
            }

        case .payment:
            VStack(alignment: .leading) {
                HStack {
                    HStack {

                        Text("Price amount")
                        .font(.system(size: 12, weight: .bold))
                        .lineLimit(2)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .onTapGesture {
                            showBottomSheet(type: .changeCoin)
                        }

                        CustomTextField(text: $amountTransaction, onEditingChanged: $onEditingChanged, placeHolderStr: "0.00")
                    }
                    .padding(.horizontal, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.white) )

                    // Crypto amount

                    HStack {

                        Text("Crypto amount")
                        .font(.system(size: 12, weight: .bold))
                        .lineLimit(2)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .onTapGesture {
                            showBottomSheet(type: .changeCoin)
                        }

                        CustomTextField(text: $amountCryptoTransaction, onEditingChanged: $onEditingChanged, placeHolderStr: "0.00")
                    }
                    .padding(.horizontal, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.white)
                    )
                }
                Text("* Minimum buying amount 4961400 VND")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.red)
                VStack (spacing: 8){
                    HStack {
                        Text("Limit")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white.opacity(0.6))
                        Spacer()
                        Text("493320 VND - 59198400 VND")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                    }
                    HStack {
                        Text("You receive")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white.opacity(0.6))
                        Spacer()
                        Text("0 USDT")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                    }

                }
                .padding(.vertical, 16)

                VStack(alignment: .leading) {
                    Text("Payment Method")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white.opacity(0.5))
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                        HStack(spacing: 6) {
                            Color.orange.frame(width: 4, height: 16)
                            Text("Bank Transfer")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.trailing, 8)
                        HStack(spacing: 6) {
                            Color.red.frame(width: 4, height: 16)
                            Text("ViettelPay")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.trailing, 8)
                    }


                }
                .padding(.all, 4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.black)
                )

                Spacer()
                HStack{
                    Spacer()
                    Text(isBuy ? "Buy USDT" : "Sell")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 8).foregroundColor(isBuy ? .green : .red))
                .padding(.bottom, 16)

            }
        case .changeCoin:
            VStack {
                SearchField(searchQuery: $searchFiat, placeHolder: "Search", texSize: 13, iconSize: 16)

                buildListCoin()
            }

        default:
            EmptyView()
        }
    }

    @ViewBuilder
    func buildListCoin() -> some View {
        ScrollView(.vertical) {
            LazyVStack() {
                ForEach(DeveloperPreview.shared.conins15){ coin in

                    Button(action: {buyCoin = coin}) {
                        HStack {
                            WebImage(url: URL(string: coin.image ?? ""))
                                .resizable()
                                .frame(width: 18, height: 18)

                            Text(coin.name ?? "N/A")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.all, 16)
                        .background(
                            Color.theme.mainColor.opacity(coin.name == buyCoin?.name ? 1 : 0)
                                .cornerRadius(6, corners: .allCorners)
                        )
                    }                }
            }
        }
    }

    @ViewBuilder
    func buidListSellTransaction() -> some View{
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(0..<12, id: \.self) { _ in
                    showP2PTransaction(isSell: true)
                }
            }
        }
    }

    @ViewBuilder
    func buidListBuyTransaction() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(0..<12, id: \.self) { _ in
                    showP2PTransaction(isSell: false)
                }
            }
        }
    }

    @ViewBuilder
    func showP2PTransaction(isSell: Bool) -> some View {
        VStack {
            HStack {
                Image("ic_batman")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 26, height: 26)
                Text("Alex sandara Ah")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()

                Text("Deals 4916 Time 11 m")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white.opacity(0.5))
            }

            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("24709")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    +
                    Text(" VND")
                        .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)

                    //Quantity
                    Text("Quantity ")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white.opacity(0.5))
                    +
                    Text("938.00 USDT")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)

                    //Quantity
                    Text("Limit ")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white.opacity(0.5))
                    +
                    Text("4941800VND - 23177042 VND")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                }
                Spacer()
                Button(action: {
                    showBottomSheet(type: .payment)
                }, label: {
                    Text(isSell ? "Sell" : "Buy")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                })
                .padding(.vertical, 4)
                .padding(.horizontal, 16)
                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(isSell ? .red : .green))
            }

            HStack {
                HStack(spacing: 6) {
                    Color.orange.frame(width: 4, height: 16)
                    Text("Bank Transfer")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))
                }
                .padding(.trailing, 8)
                HStack(spacing: 6) {
                    Color.pink.frame(width: 4, height: 16)
                    Text("MoMo")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))
                }
                Spacer()
            }

            Color.white.opacity(0.7).frame(height: 1)
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

struct P2PTransactionInfo: Identifiable {
    let id: UUID
    let name: String
    let price: Double
    let currency: String
    let quantity: Double
    let minAmount: Double
    let maxAmount: Double
    let supportPayment: [P2PPaymenType]

}

enum P2PPaymenType {
    case bank
    case aliPay
    case weChat
    case swiftInternationalRemittance
    case payPal
    case fps
    case wise
    case ShoppeePay
    case cake
    case momo
    case viettelPay
    case zaloPay

    var name: String {
        switch self {
        case .bank:
            return "Bank Transfer"
        case .aliPay:
            return "Alipay"
        case .weChat:
            return "WeChat"
        case .swiftInternationalRemittance:
            return "Swift international remittance"
        case .payPal:
            return "PayPal"
        case .fps:
            return "FPS"
        case .wise:
            return "Wise"
        case .ShoppeePay:
            return "ShoppeePay"
        case .cake:
            return "Cake"
        case .momo:
            return "MoMo"
        case .viettelPay:
            return "Viettel Pay"
        case .zaloPay:
            return "ZaloPay"
        }
    }

    var color: some View {
        switch self {
        case .bank:
            return Color(#colorLiteral(red: 0.7106785774, green: 0.4927070141, blue: 0.07058734447, alpha: 1)).frame(width: 4, height: 16)
        case .aliPay:
            return Color.orange.frame(width: 4, height: 16)
        case .weChat:
            return Color.green.frame(width: 4, height: 16)
        case .swiftInternationalRemittance:
            return Color.orange.frame(width: 4, height: 16)
        case .payPal:
            return Color(#colorLiteral(red: 0.3619742782, green: 0.6329328029, blue: 0.8382223248, alpha: 1)).frame(width: 4, height: 16)
        case .fps:
            return Color.orange.frame(width: 4, height: 16)
        case .wise:
            return Color(#colorLiteral(red: 0.8382223248, green: 0.4386712401, blue: 0.8236013574, alpha: 1)).frame(width: 4, height: 16)
        case .ShoppeePay:
            return Color.orange.frame(width: 4, height: 16)
        case .cake:
            return Color.orange.frame(width: 4, height: 16)
        case .momo:
            return Color.pink.frame(width: 4, height: 16)
        case .viettelPay:
            return Color.red.frame(width: 4, height: 16)
        case .zaloPay:
            return Color.blue.frame(width: 4, height: 16)

        }
    }
}
