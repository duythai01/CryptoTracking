//
//  WithDrawViewUI.swift
//  CryptoTracking
//
//  Created by DuyThai on 31/10/2023.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

//  Withdraw View child
extension WithdrawView {

    var switchButton: some View {
        GeometryReader { geometryH in
            HStack {
                HStack {
                    Image(systemName: "line.diagonal.arrow")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(!isDeposit ? .white : .purple)

                    Text("Withdraw")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(!isDeposit ? .white : .purple)
                }
                .frame(width: geometryH.size.width / 2 - 6)
                .padding(.vertical, 16)
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.1)) {
                        isDeposit = false
                    }
                }
                Spacer()
                HStack {
                    Image(systemName: "line.diagonal.arrow")
                        .font(.system(size: 18, weight: .bold))
                        .rotationEffect(Angle(degrees: 90))
                        .foregroundColor(!isDeposit ? .purple : .white)

                    Text("Deposit")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(!isDeposit ? .purple : .white)
                }
                .frame(width: geometryH.size.width / 2 - 6)
                .padding(.vertical, 16)
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.1)) {
                        isDeposit = true
                    }
                }
            }
            .background(
                GeometryReader{ backgroundGeometry in
                    Color.white.opacity(0.2)
                        .cornerRadius(12)
                        .background(HStack{
                            if isDeposit {
                                Spacer()
                            }
                            Color.purple
                                .frame(width: geometryH.size.width / 2 - 6)
                                .cornerRadius(6)
                                .padding(.all, 5)
                            if !isDeposit {
                                Spacer()
                            }
                    })
                        .onAppear {
                            DispatchQueue.main.async {
                                heightSwitchButton = backgroundGeometry.size.height
                            }
                        }
                    
                }

            )
        }
        .frame(height: heightSwitchButton)
        .padding(.horizontal, 42)
    }

    var selectionChangeType: some View {
        VStack(alignment: .center) {
//            HStack {
//                Spacer()
//                Text("Withdraw with \(methodWithdrawType.name)")
//                    .font(.system(size: 16, weight: .bold))
//                    .foregroundColor(.white )
//                Image(systemName: "arrowtriangle.down.fill")
//                    .font(.system(size: 13, weight: .medium))
//                    .foregroundColor(.white)
//                Spacer()
//            }
//            .padding(12)
//            .background(Color.blue.opacity(0.4).cornerRadius(8))
//            .onTapGesture {
//                showBottomSheet(type: .paymentMethod)
//            }

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
                                isShowChangeBottomView = true
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(onEditingChangedAmounTextField ? .blue : .white.opacity(0.5), lineWidth: 1))

                        Image(systemName: "arrow.right")
                            .font(.system(size: 15, weight:  .bold))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    Text("Available: \(changeCoin?.currentHoldingsValue ?? 0.000000) \(changeCoin?.symbol ?? "")")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.white.opacity(0.6))
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
                        showBottomSheet(type: .receiveCoin)
                        isShowChangeBottomView = false
                    }

                    Spacer()
                }
            }

        }
        .fixedSize(horizontal: false, vertical: true)
        .padding([.horizontal, .top], 10)
    }

    var paymentChannel: some View {
        VStack() {
            HStack {
                Text("Choose a payment chanel")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.bottom, 8)

            VStack(alignment: .leading) {
                Text("Recommended")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white.opacity(0.6))
                ForEach(DeveloperPreview.shared.recommendedChanel) {chanel in
                    paymentChanelItem(chanel: chanel)
                }
                .padding(.bottom, 16)

                Text("Others")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white.opacity(0.6))
                ForEach(DeveloperPreview.shared.otherChanel) {chanel in
                    paymentChanelItem(chanel: chanel)
                }

                Spacer()
            }
            .padding(.horizontal, 10)
        }
    }

    @ViewBuilder
    func paymentChanelItem(chanel: PaymentChanel) -> some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image("ic_binance")
                        .resizable()
                        .frame(width: 18, height: 18 )
                    Text(chanel.name)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)

                    //Chanel tag
                    Text("HOT")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 4)
                        .background(Color.orange.cornerRadius(2, corners: .allCorners))
                }

                Text(chanel.exchangeRate)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white.opacity(0.8))
                // Payment support
                HStack {
                    ForEach(chanel.paymentSupport, id: \.self) { method in
                        method.icon
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 18)
                            .cornerRadius(2, corners: .allCorners)
                    }
                }

            }
            .padding(.horizontal ,16)
            .padding(.vertical, 8)
            Spacer()

            Circle()
                .stroke(lineWidth: 1)
                .frame(width: 22, height: 22)
                .foregroundColor(.white.opacity(0.7))
                .background(
                    Circle()
                        .foregroundColor(
                            paymentChanelSelected == chanel ? .blue : .clear)
                        .padding(4)
                )
                .padding(.trailing, 16)
        }
        .background( paymentChanelSelected == chanel ? .blue.opacity(0.2) : Color.black.opacity(0.2))
        .cornerRadius(6, corners: .allCorners)
        .overlay(RoundedRectangle(cornerRadius: 6)
            .stroke(
                paymentChanelSelected == chanel ? .blue : Color.white.opacity(0.4),
                lineWidth: 2))
        .onTapGesture {
            if paymentChanelSelected == chanel {
                self.paymentChanelSelected = nil
            } else {
                self.paymentChanelSelected = chanel
            }
        }

    }

    var paymentDetail: some View {
        VStack {
            HStack {
                Text("Payment details")
                    .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                Spacer()
            }
            .padding(.bottom, 8)
            VStack(spacing: 16) {
                HStack {
                    Text("Amount")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Text("10,0000USD")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)

                }

                HStack {
                    Text("Estimated to receive")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Text("9,569.659 USDT")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)

                }

                HStack {
                    Text("Unit Price")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))
                    Spacer()
                    Text("1 USDT ≈ 1.04 USD")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))

                }

                HStack {
                    Text("Service Provider")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))
                    Spacer()
                    HStack(alignment: .center) {
                        Image("ic_bitcoin")
                            .resizable()
                        .frame(width: 16, height: 16)
                        Text("BANXA")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                        Text("Connect")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.blue)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 4)
                            .background(Color.orange.opacity(0).cornerRadius(2, corners: .allCorners))
                    }
                }


                HStack {
                    Text("Estimated arrival time")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))
                    Spacer()
                    Text("5 - 10 minutes")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.5))
                }

                HStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 2)

                        .stroke(lineWidth: 1)
                        .foregroundColor(isReadPolicy ? .blue : .white.opacity(0.8))
                        .background(Color.blue.opacity(isReadPolicy ? 1 : 0.1))
                        .overlay(
                            VStack {
                                if isReadPolicy {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.white)
                                }

                            }
                        )
                        .onTapGesture {
                            isReadPolicy.toggle()
                        }
                        .frame(width: 18, height: 18)

                    Text("I have read and agree to ")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white) +
                    Text("Gate Global UAB Terms")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.blue ) +
                    Text(" and ")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white) +
                    Text("Gate Global UAB Privacy Policy")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.blue) +
                    Text(". ")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                    Spacer()
                }
                Button(action: {}, label: {
                    HStack {
                        Spacer()
                        Text("Continue")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 16)

                        Spacer()
                   }
                })
                .background(VStack {
                    isReadPolicy ? Color.blue.cornerRadius(12) : Color.gray.opacity(0.5).cornerRadius(12)
                } )
                .padding(.top, 16)

            }
            .padding(16)
            .background(Color.gray.opacity(0.2).cornerRadius(12))
            .redacted(reason: isLoadPaymentDetailDone ? [] : .placeholder)

        }
    }
}

