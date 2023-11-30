//
//  ExchangeView.swift
//  CryptoTracking
//
//  Created by DuyThai on 29/11/2023.
//

import SwiftUI

struct ExchangeView: View {
    @StateObject var viewModel = ExchangeViewModel()
    @State var showBottomSheetType: WithdrawSheetSelection = .none
    @State var bottomSheetMode: BottomSheetViewMode = .none
    @State var searchName: String = ""
    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            VStack{
                ZStack {
                    VStack(spacing: 20) {
                        VStack(spacing: 12) {
                            HStack {
                                Text("You pay")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white.opacity(0.6))
                                Spacer()
                                Text("Balance: 1.17 BTC")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            HStack {
                                TextField("", text: $viewModel.payAmount){ change in
                                    print("@@@Textfiel: \(change)")
                                    viewModel.isPayAmounEdit = change
                                }
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .multilineTextAlignment(.leading)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: viewModel.payAmount) { newValue in
                                        // Replace commas with periods
                                        let newValueWithoutCommas = newValue.replacingOccurrences(of: ",", with: ".")
                                        // Update the state with the modified value
                                        viewModel.payAmount = newValueWithoutCommas
                                    }
                                Spacer()
                                HStack{
                                    Text(viewModel.payRate?.unit ?? "N/A")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white)

                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Capsule().stroke(.white.opacity(0.5), lineWidth: 1))
                                .onTapGesture {
                                    showBottomSheet(type: .flag)
                                }
                            }
                        }
                        .padding(.all, 16)
                        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color(#colorLiteral(red: 0.2918200293, green: 0.3435840526, blue: 0.4371835719, alpha: 0.6))))

                        VStack(spacing: 12) {
                            HStack {
                                Text("You get")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white.opacity(0.6))
                                Spacer()
                                Text("= 2335.22 USD")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white.opacity(0.6))
                            }
                            HStack {
                                TextField("", text: $viewModel.getAmount)
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .multilineTextAlignment(.leading)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: viewModel.getAmount) { newValue in
                                        // Replace commas with periods
                                        let newValueWithoutCommas = newValue.replacingOccurrences(of: ",", with: ".")
                                        // Update the state with the modified value
                                        viewModel.getAmount = newValueWithoutCommas
                                    }
                                Spacer()
                                HStack{
                                    Text(viewModel.getRate?.unit ?? "N/A")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white)

                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Capsule().stroke(.white.opacity(0.5), lineWidth: 1))
                                .onTapGesture {
                                    showBottomSheet(type: .changeCoin)
                                }
                            }
                        }
                        .padding(.all, 16)
                        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(Color(#colorLiteral(red: 0.2918200293, green: 0.3435840526, blue: 0.4371835719, alpha: 0.6))))
                    }

                    Image(systemName: "arrow.up.arrow.down")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.all, 16)
                        .background( Circle()
                            .foregroundColor(.purple))
                        .overlay(Circle()
                            .stroke(lineWidth: 4)
                            .foregroundColor(.theme.mainColor))
                }

                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 1, alignment: .bottom)
                    .overlay(
                        Line()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .frame(height: 1)
                        .foregroundColor(.white)
                    )
                    .padding(.top, 32 )

                VStack(spacing: 10) {
                    HStack(alignment: .top) {
                        Text("Address wallet")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white.opacity(0.6))
                        Spacer()
                        Text("0x111CecD9618D45Cb0f94fdb4801D01c91bBAF0Ba")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: UIScreen.main.bounds.width / 2)
                    }

                    HStack {
                        Text("Rate")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white.opacity(0.6))
                        Spacer()
                        Text("1 \(viewModel.payRate?.unit ?? "N/A") = \(viewModel.payVsGetRate.formatTwoNumbeAfterDot(minimumFractionDigits: 0,maximumFractionDigits: 6)) \(viewModel.getRate?.unit ?? "N/A")")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.orange)
                    }

                    HStack {
                        Text("Network fee")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white.opacity(0.6))
                        Spacer()
                        Text("0.00001 %")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }

                    HStack {
                        Text("Discount")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white.opacity(0.6))
                        Spacer()
                        Text("0 %")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }

                    Spacer()
                    Button(action: {}, label: {
                        HStack {
                            Spacer()
                            Text("Exchange")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.vertical, 16)

                            Spacer()
                       }
                    })
                    .background(Color.blue.opacity(0.7).cornerRadius(12) )

                }
                .padding(.top, 16)

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
        .navigationTitle(Text("EXCHANGE"))
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
        .onAppear{
            viewModel.getRates()
        }
    }

    var bottomSheet: some View {
        ZStack {
            Color(#colorLiteral(red: 0.09111639081, green: 0.07618386149, blue: 0.1349048857, alpha: 1))
                .cornerRadius(16, corners: [.topLeft, .topRight])
            VStack {
                HStack {

                    Text("Select currency")
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
                bottomSheetMode = .custom(heightRatio: 0.75)

            case .changeCoin:
                bottomSheetMode = .custom(heightRatio: 0.75)
            default:
                bottomSheetMode = .none
            }
    }

    @ViewBuilder
    func buildBodyViewSheet() -> some View {
        switch showBottomSheetType {
        case .flag:
            VStack {
                SearchField(searchQuery: $searchName, placeHolder: "Search", texSize: 13, iconSize: 16)
                buildListCurrency(isPay: true)
            }
        case .changeCoin:
            VStack {
                SearchField(searchQuery: $searchName, placeHolder: "Search", texSize: 13, iconSize: 16)

                buildListCurrency(isPay: false)
            }

        default:
            EmptyView()
        }
    }

    @ViewBuilder
    func buildListCurrency(isPay: Bool) -> some View {
        ScrollView(.vertical) {
            LazyVStack() {
                ForEach(isPay ? viewModel.payRateKey : viewModel.getRateKey, id: \.self){ key in

                    Button(action: {
                        isPay ? (viewModel.payRate = viewModel.ratesPayDisplay[key]) : (viewModel.getRate = viewModel.ratesGetDisplay[key])

                    }) {
                        HStack {

                            Text(key)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.all, 16)
                        .background(
                            Color.theme.mainColor.opacity((!isPay ? (viewModel.getRate == viewModel.ratesGetDisplay[key]) : (viewModel.payRate == viewModel.ratesPayDisplay[key])) ? 1 : 0)
                                .cornerRadius(6, corners: .allCorners)
                        )
                    }                }
            }
        }
    }
}

struct ExchangeView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeView()
    }
}
struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
