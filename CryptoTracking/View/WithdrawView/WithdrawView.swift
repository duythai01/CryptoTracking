//
//  SwiftUIView.swift
//  CryptoTracking
//
//  Created by DuyThai on 25/10/2023.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct WithdrawView: View {
    @EnvironmentObject var coordinator: Coordinator<AppRouter>

    @State var amountStr: String = ""
    @State var changeCoin: Coin? = DeveloperPreview.shared.conins15[0]
    @State var receiveCoin: Coin? = DeveloperPreview.shared.conins15[1]
    @State var depositeCoin: Coin? = DeveloperPreview.shared.conins15[1]
    @State var onEditingChangedAmounTextField: Bool = false
    @State var bottomSheetMode: BottomSheetViewMode = .none
    @State var modalViewOpacity: CGFloat = 0
    @State var searchCoin: String = ""
    @State var isShowChangeBottomView: Bool = false
    @State var heightSwitchButton: CGFloat = 0
    @State var isReadPolicy: Bool = false
    @State var isLoadPaymentDetailDone: Bool = false
    @State var methodType: WithDrawMethodType = .card
    @State var showBottomSheetType: WithdrawSheetSelection = .none
    @State var mainScrollProxy: ScrollViewProxy?
    @State var methodWithdrawType: WithDrawMethodType = .card
    @State var paymentChanelSelected: PaymentChanel?
    @State var isDeposit: Bool = false
    @State var depositNetworkName = "BSC/BEP20"
    @State var isLoadInformDeposit = true


    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    let depositNework = ["ETH/ERC20", "BSC/BEP20", "Arabitrum One", "Arabitrum Nova", "ZkSync Era", "Optimism"]


    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            VStack (spacing: 16){
                ScrollViewReader { proxy in
                    ScrollView(.vertical) {
                        VStack(spacing: 16) {
                            switchButton
                                .id("switchButton")

                            if isDeposit {
                                depositView
                            } else {
                                selectionChangeType
                                    .id("selectionChangeType")

                                paymentChannel
                                    .padding(.vertical, 8)
                                    .id("paymentChannel")

                                paymentDetail
                                    .id("paymentDetail")
                            }

                            Spacer()
                        }
                        .padding(.horizontal, 16)
                    }
                    .onAppear{
                        mainScrollProxy = proxy
                    }
                }
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
        .navigationTitle(Text("WITHDRAW"))
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
        .onAppear {
            depositNetworkName = depositNework[0]
        }
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
                    Text(showBottomSheetType.sectionTitle)
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

                buildBodyViewSheet()

                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }

    @ViewBuilder
    func buildListCoin() -> some View {
        ScrollView(.vertical) {
            LazyVStack() {
                ForEach(DeveloperPreview.shared.conins15){ coin in
                    var isSelected: Bool = showBottomSheetType == .depositCoin
                                                                    ? depositeCoin?.name ?? "" == coin.name ?? ""
                                                                    : (showBottomSheetType == .changeCoin
                                                                    ? changeCoin?.name ?? "" == coin.name ?? ""
                                                                    :receiveCoin?.name ?? "" == coin.name ?? "" )



                    CoinRow(coin: coin, isSelected: isSelected) {
                        if showBottomSheetType == .depositCoin {
                            depositeCoin = coin
                        } else if showBottomSheetType == .changeCoin {
                            changeCoin = coin
                        }  else if showBottomSheetType ==  .receiveCoin{
                            receiveCoin = coin
                        }
                   }
                }
            }
        }
    }

    func CoinRow(coin: Coin, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
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
        }
    }


    @ViewBuilder
    func buildBodyViewSheet() -> some View {
        switch showBottomSheetType {
        case .changeCoin, .receiveCoin, .depositCoin:
            VStack {
                SearchField(searchQuery: $searchCoin, placeHolder: "Search", texSize: 13, iconSize: 16)
                buildListCoin()
            }
        case .paymentMethod:
            ForEach(WithDrawMethodType.allCases, id: \.self) { method in
                Button(action: {
                    withAnimation(.easeOut(duration: 0.2)) {
                        methodWithdrawType = method
                        showBottomSheet(type: .none)
                    }
                }, label: {
                    HStack {
                        method.icon
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.all, 8)
                            .background(Circle()
                                .foregroundColor(.purple))
                        Text(method.name)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.all, 16)
                })
                .background( methodWithdrawType == method ? Color.blue.opacity(0.4).cornerRadius(12) :  Color.theme.mainColor.cornerRadius(12))
            }
        case .depositMethod:
            EmptyView()
        case .none:
            EmptyView()
        case .depositNetwork:
            ForEach(depositNework, id: \.self) { name in
                Button(action: {
                    withAnimation(.easeOut(duration: 0.2)) {
                        depositNetworkName = name
                        showBottomSheet(type: .none)
                    }
                }, label: {
                    HStack {
                        Text(name)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.all, 16)
                })
                .background( depositNetworkName == name ? Color.blue.opacity(0.4).cornerRadius(12) :  Color.theme.mainColor.cornerRadius(12))

            }

        default:
            EmptyView()
        }
    }
}
// Withdraw View func
extension WithdrawView {
    func showBottomSheet(type: WithdrawSheetSelection) {
            modalViewOpacity = 0.5
            showBottomSheetType = type
            switch type {
            case .changeCoin:
                bottomSheetMode = .custom(heightRatio: 0.75)
//                if let mainScrollProxy = mainScrollProxy {
//                    withAnimation {
//                        mainScrollProxy.scrollTo("selectionChangeType")
//                    }
//                }

            case .receiveCoin:
                bottomSheetMode = .custom(heightRatio: 0.75)
//                if let mainScrollProxy = mainScrollProxy {
//                    withAnimation {
//                        mainScrollProxy.scrollTo("selectionChangeType")
//                    }
//                }
            case .paymentMethod:
                bottomSheetMode = .custom(heightRatio: 0.4)
//                if let mainScrollProxy = mainScrollProxy {
//                    withAnimation {
//                        mainScrollProxy.scrollTo("paymentChannel")
//                    }
//                }
            case .depositMethod:
                bottomSheetMode = .custom(heightRatio: 0.75)
//                if let mainScrollProxy = mainScrollProxy {
//                    withAnimation {
//                        mainScrollProxy.scrollTo("paymentChannel")
//                    }
//                }
            case .none:
                bottomSheetMode = .none
                break
            case .depositCoin:
                bottomSheetMode = .custom(heightRatio: 0.75)

            case .depositNetwork:
                bottomSheetMode = .custom(heightRatio: 0.7)
            default:
                bottomSheetMode = .none
            }
    }

    func genenrateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct WithdrawView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawView()
    }
}

