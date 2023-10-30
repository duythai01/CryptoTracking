//
//  SwiftUIView.swift
//  CryptoTracking
//
//  Created by DuyThai on 25/10/2023.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI

enum WithDrawMethodType {
    case card
    case p2pExpresee
    case p2p
    case bank

    var name: String {
        switch self {
        case .card:
            return "Debit/Credit Card"
        case .p2pExpresee:
            return "P2P Express"
        case .p2p:
            return "P2P"
        case .bank:
            return "Bank Transfer"
        }
    }

    var icon: Image {
        switch self {
        case .card:
            return Image(systemName: "person.2.fill")
        case .p2pExpresee:
            return Image(systemName: "person.2.gobackward")
        case .p2p:
            return Image(systemName: "person.line.dotted.person.fill")
        case .bank:
            return Image(systemName: "creditcard.fill")
        }
    }
}

struct WithdrawView: View {
    @State var isBuySelection: Bool = true
    @State var hideMoney: Bool = true
    @State var amountStr: String = ""
    @State var changeCoin: Coin? = DeveloperPreview.shared.conins15[0]
    @State var receiveCoin: Coin? = DeveloperPreview.shared.conins15[1]
    @State var onEditingChangedAmounTextField: Bool = false
    @State var bottomSheetMode: BottomSheetViewMode = .none
    @State var modalViewOpacity: CGFloat = 0
    @State var searchCoin: String = ""
    @State var isShowChangeBottomView: Bool = false
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 26, weight: .bold)] // Set the text
        UINavigationBar.appearance().standardAppearance = appearance
    }

    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()

            ScrollView(.vertical) {
                VStack {
                    if $bottomSheetMode.wrappedValue == .none {
                        currenceAssets
                            .id(1)
                            .animation(.easeIn(duration: 0.2))
                            .transition(.scale)
                    }
                    switchButton
                        .padding(.bottom, 48)
                        .id(2)
                    selectionChangeType
                        .id(3)


                    Spacer()
                }
                .padding(.horizontal, 16)
            }

            //Modal layer
            if bottomSheetMode != .none {
                Color.black.opacity(modalViewOpacity).ignoresSafeArea()
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
        .navigationTitle(Text("Withdraw"))
        .navigationBarTitleDisplayMode(.inline)

    }

}
//  Withdraw View child
extension WithdrawView {
    var switchButton: some View {
        GeometryReader { geometryH in
            HStack {
                HStack {
                    Image(systemName: "line.diagonal.arrow")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(isBuySelection ? .white : .purple)

                    Text("Withdraw")
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

                    Text("Deposit")
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
                    Image(systemName: hideMoney ? "eye.slash.circle.fill" : "eye.circle.fill")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white.opacity(0.8))
                        .onTapGesture {
                            hideMoney.toggle()
                        }
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
            //                VStack(spacing: 6) {
            //                    Image("ic_wallet")
            //                    Text("Your account has no assets.")
            //                        .font(.system(size: 16, weight: .bold))
            //                        .foregroundColor(.white.opacity(0.7))
            //                    Text("Deposit now to start.")
            //                        .font(.system(size: 14, weight: .bold))
            //                        .foregroundColor(.white.opacity(0.5))
            //                }
        }
    }

    var selectionChangeType: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Text ("Withdraw with Debit/Credit Card")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white )
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(12)
            .background(Color.blue.opacity(0.4).cornerRadius(8))

            GeometryReader { geometry in
                HStack{
                    // Change
                    VStack(alignment: .leading) {
                        Text("I want to change")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                        HStack {
                            HStack {
                                // TextField
                                CustomTextField(text: $amountStr, onEditingChanged: $onEditingChangedAmounTextField)
                                    .padding(.leading, 8)
                                // Select coin
                                HStack{
                                    WebImage(url: URL(string: changeCoin?.image ?? ""))
                                        .resizable()
                                        .frame(width: 16, height: 16)

                                    Text(changeCoin?.name ?? "N/A")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.white)

                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundColor(.white)
                                        .padding(.leading, 4)
                                }
                                .padding(.vertical, 8)
                                .padding(.trailing, 8)
                                .onTapGesture {
                                    showBottomSheet(isShowChangeBottomView: true)
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(onEditingChangedAmounTextField ? .blue : .white.opacity(0.5), lineWidth: 1))

                            Image(systemName: "arrow.right")
                                .font(.system(size: 15, weight:  .bold))
                                .foregroundColor(.white.opacity(0.6))
                        }

                    }

                    // Receive
                    VStack(alignment: .leading) {
                        Text("Receive")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))


                            HStack{
                                WebImage(url: URL(string: receiveCoin?.image ?? ""))
                                    .resizable()
                                    .frame(width: 16, height: 16)

                                Text(receiveCoin?.name ?? "N/A")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white)

                                Image(systemName: "chevron.down")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.leading, 8)
                            }
                            .padding(.all, 8)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(.white.opacity(0.5), lineWidth: 1))
                        .onTapGesture {
                            showBottomSheet(isShowChangeBottomView: false)
                        }

                    }
                }
            }
        }
        .padding([.horizontal, .top], 10)
    }
}

// Withdraw Bottom sheet
extension WithdrawView {
    var bottomSheet: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1598833799, green: 0.1648724079, blue: 0.2934403419, alpha: 1))
                .cornerRadius(16, corners: [.topLeft, .topRight])
            VStack {
                HStack {
                    Text("Select Currency")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white.opacity(0.7))
                        .onTapGesture {
                            bottomSheetMode = .none
                        }
                }
                .padding(.top, 16)
                SearchField(searchQuery: $searchCoin, placeHolder: "Search", texSize: 13, iconSize: 16)
                showListCoin()
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }

    @ViewBuilder
    func showListCoin() -> some View {
        ScrollView(.vertical) {
            LazyVStack() {
                ForEach(DeveloperPreview.shared.conins15){ coin in
                    let isSelected = (isShowChangeBottomView ? changeCoin?.name ?? "" : receiveCoin?.name ?? "") == coin.name ?? ""
                    VStack {
                        Button(action: {
                                if isShowChangeBottomView {
                                    changeCoin = coin
                                } else {
                                    receiveCoin = coin
                                }
                        }, label: {
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
                                Color.theme.mainColor.opacity(isSelected ? 1 : 0)
                                    .cornerRadius(6, corners: .allCorners)

                            )

                    })
                    }

                }
            }
        }
    }
}

// Withdraw View func
extension WithdrawView {
    func showBottomSheet(isShowChangeBottomView: Bool) {
        if bottomSheetMode != .none {
            bottomSheetMode = .none
        } else {
            modalViewOpacity = 0.5
            bottomSheetMode = .custom(heightRatio: 0.75)
            self.isShowChangeBottomView = isShowChangeBottomView
        }
    }
}

struct WithdrawView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawView()
    }
}

struct CustomTextField: View {
    @Binding var text: String
    @Binding var onEditingChanged: Bool
    var body: some View {
        ZStack(alignment: .leading) {
            if text == "" {

                Text("0")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.gray.opacity(0.5))
            }

            TextField("", text: $text, onEditingChanged: { changed in
                onEditingChanged = changed
            }) {
                UIApplication.shared.dismissKeyboard()

            }
            .keyboardType(.decimalPad)
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(.white.opacity(0.8))
            .accentColor(.white.opacity(0.8))
        }
    }
}

