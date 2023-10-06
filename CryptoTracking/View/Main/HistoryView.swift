//
//  WalletView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI

enum TimeFilter: String, CaseIterable {
    case latest
    case thirtyMinutes
    case oneHour
    case twelfthHour
    case oneDay
    case oneWeek
    case oneMonth
    case sixMonth
    case oneYear

    var displayName: String {
        switch self {
        case .latest:
            return "Latest"
        case .thirtyMinutes:
            return "30m"
        case .oneHour:
            return "1h"
        case .twelfthHour:
            return "12h"
        case .oneDay:
            return "1d"
        case .oneWeek:
            return "1w"
        case .oneMonth:
            return "1 month"
        case .sixMonth:
            return "6 month"
        case .oneYear:
            return "1y"
        }
    }
}

enum Filter: String, CaseIterable {
    case increase
    case decrease
    case coin
    case network
}

struct HistoryView: View {
    @State private var searchText = ""
    @State private var searchIsActive = false
    @State private var selectedTab: Int = 1

    let transactionsSend: [Int] = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
    let transactionsReceive: [Int] = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
    var body: some View{
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            VStack {
                HistoryHeaderView(searchQuery: $searchText)
                HStack {
                    tabButton(title: "All", tag: 1)

                    tabButton(title: "Send", tag: 2)

                    tabButton(title: "Receive", tag: 3)
                }
                .padding(.top)
                .font(.headline)
                HStack {
                    HStack {
                        Image("ic_filter")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)

                        Text("Filter")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                    Spacer()
                    Text("2023/09/06")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                }
                .padding(.horizontal, 16)
                .padding(.top)
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [GridItem(.flexible())], spacing: 25) {
                            ForEach(TimeFilter.allCases.indices, id: \.self) { index in
                                let category = TimeFilter.allCases[index]
                                HStack {
                                    HStack(alignment: .center) {
                                        Text(category.displayName)
                                            .font(.system(size: 13, weight: .medium))
                                            .foregroundColor(.white)
                                    }.padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                }
                                .background(
                                    Capsule()

                                )
                            }
                        }

                    }
                    .background(Color.red)
                }.fixedSize(horizontal: false, vertical: true)
                TabView(selection: $selectedTab) {
                    VStack {
                        List {
                            ForEach(transactionsSend, id:\.self) { transactionsSend in
                                CoinCard(imageCoin: Image("ic_bitcoin"), nameCoin: "0.004 BTC", symbol: "Bitcoin", moneyAmount: (transactionsSend.isMultiple(of: 2) ? "+" : "-") + "$ 5,432.002", status: "2023/09/06, 9:07 AM", isHistory: true)
                            }

                        }
                        .listStyle(.plain)


                    }
                    .padding(.horizontal, 16).tag(1)
                    VStack {
                        List {
                            ForEach(transactionsSend, id:\.self) { transactionsSend in
                                CoinCard(imageCoin: Image("ic_bitcoin"), nameCoin: "0.004 BTC", symbol: "Bitcoin", moneyAmount: "-$ 5,432.002", status: "2023/09/06, 9:07 AM", isHistory: true)
                            }

                        }
                        .listStyle(.plain)
                    }
                    .padding(.horizontal, 16).tag(2)
                    VStack {
                        List {
                            ForEach(transactionsSend, id:\.self) { transactionsSend in
                                CoinCard(imageCoin: Image("ic_bitcoin"), nameCoin: "0.009 BTC", symbol: "Bitcoin", moneyAmount: "+$ 5,432.002", status: "2023/09/06, 9:07 AM", isHistory: true)
                            }

                        }
                        .listStyle(.plain)


                    }
                    .padding(.horizontal, 16).tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                Spacer()
            }
        }
    }

    func tabButton(title: String, tag: Int) -> some View {
        VStack {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .onTapGesture { withAnimation(.easeIn) { selectedTab = tag } }
                .frame(maxWidth: .infinity)
                .foregroundColor(selectedTab == tag ? .white : .secondary)

            Color(selectedTab == tag ? .purple : .clear)
                .frame(height: 4)
                .padding(.horizontal)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

struct HistoryHeaderView : View {
    @Binding var searchQuery: String
    @State var animation: Bool = false
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .foregroundColor(Color.purpleView)
                        .frame(width: 50, height: 50)
                        .shadow(color: .white, radius: 4)

                    Image(systemName: "calendar.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 28, height: 28)
                }
                Spacer()
                Text("History" )
                    .font(.system(size: 28
                                  , weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 2)
                Spacer()
                ZStack {
                    Circle()
                        .foregroundColor(Color.purpleView)
                        .frame(width: 50, height: 50)
                        .shadow(color: .white, radius: 4)

                    Image(systemName: "doc.text.magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 28, height: 28)
                }
                .onTapGesture {
                    withAnimation(.easeInOut.delay(0.1)) {
                        animation.toggle()
                    }
                }
            }
            .padding(.horizontal, 16)
            .frame(width: nil)

            if animation {
                SearchField(searchQuery: $searchQuery)
            }

        }
    }
}

struct SearchField: View {
    @Binding var searchQuery: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .padding(8)

            TextField("Search your transaction", text: $searchQuery)
                .font(.system(size: 16, weight: .medium))

        }
        .background(
            Capsule()
                .foregroundColor(.white.opacity(0.4))
        )
        .padding(.horizontal, 24)
        .transition(.scale.combined(with: .opacity))
    }
}
