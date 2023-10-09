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

enum FilterTransaction: String, CaseIterable, Identifiable {
    case latest
    case increase
    case decrease
    case coin
    case network

    var id: Self {
        return self
    }

    var displayName: String {
        switch self {
        case .latest:
            return "Latest"
        case .increase:
            return "Increase"
        case .decrease:
            return "Decrease"
        case .coin:
            return "Coin"
        case .network:
            return "NetWork"
        }
    }
}

struct HistoryView: View {
    @State private var searchText = ""
    @State private var searchIsActive = false
    @State private var selectedTab: Int = 1
    @State private var dateSelection = Date()
    @State private var filterSelection: FilterTransaction = .latest
    @State private var isExpandedFilter: Bool = false
    @State private var heightDropmenu: CGFloat = 295


    var body: some View{
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isExpandedFilter = false
                    }
                }
            ZStack {
                VStack {
                    HistoryHeaderView(searchQuery: $searchText)
                    HStack {
                        tabButton(title: "All", tag: 1)

                        tabButton(title: "Send", tag: 2)

                        tabButton(title: "Receive", tag: 3)
                    }
                    .padding(.top)
                    .font(.headline)
                    FilterAndDatePicker(dateSelection: $dateSelection, selection: $filterSelection, isShowMenu: $isExpandedFilter, heightDropmenu: $heightDropmenu)

                    ListCoinPageView(selectedTab: $selectedTab)
                        .padding(.top,  isExpandedFilter ? -heightDropmenu : 0)
                    Spacer()
                }
            }
        }
    }

    func tabButton(title: String, tag: Int) -> some View {
        VStack {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .onTapGesture { withAnimation(.easeIn) { selectedTab = tag } }
                .frame(maxWidth: .infinity)
                .foregroundColor(selectedTab == tag ? .white : .white.opacity(0.5))

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
            Text("History" )
                .font(.system(size: 28
                              , weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .frame(width: nil)
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

struct FilterAndDatePicker: View {
    @Binding var dateSelection: Date
    @Binding var selection: FilterTransaction
    @Binding var isShowMenu: Bool
    @Binding var heightDropmenu: CGFloat

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    HStack {
                        Image("ic_filter")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.purple)

                        Text(selection.displayName)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width:  12 , height: 12)
                            .rotationEffect(Angle(degrees: isShowMenu ? -90 : 0))
                            .foregroundColor(.white)
                    }
                    .background(Color.theme.mainColor)
                    .onTapGesture {
                        withAnimation() {
                            isShowMenu.toggle()
                        }
                    }

                    Spacer()
                }

                DatePicker(selection: $dateSelection, in: ...Date(), displayedComponents: .date) {
                    Button(action: {}){
                    }
                }
                .datePickerStyle(.compact)
                .accentColor(.purple)
                .environment(\.colorScheme,.dark)
            }
            .padding(.horizontal, 16)
            if isShowMenu {
                GeometryReader { geometry in
                    HStack {
                        ScrollView{
                            LazyVStack(alignment: .leading, spacing: 2) {
                                ForEach(FilterTransaction.allCases) { item in
                                    HStack {
                                        Text(item.displayName)
                                            .foregroundColor( selection == item ? .purple : .white)
                                            .font(.system(size: 16, weight: .medium))
                                        .padding(.all, 8)
                                        Spacer()
                                        if selection == item {
                                            Image(systemName: "arrowtriangle.left.fill")
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                                .foregroundColor(.purple)
                                                .padding(.trailing, 8)
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeIn(duration: 0.2)) {
                                            selection = item
                                            isShowMenu = false
                                        }
                                    }
                                }
                            }

                        }
                        .frame(width: 140)
                        .fixedSize(horizontal: true, vertical: true)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(Color.theme.mainColor.opacity(0.9))
                                .shadow(color: .white, radius: 2)
                    )
                        Spacer()
                    }
                    .onAppear {
                        heightDropmenu =  geometry.size.height
                        print("@@: \(heightDropmenu)")

                    }
                    .padding(.horizontal, 20)

                }
            }

        }
        .zIndex(20)

    }
}

struct ListCoinPageView: View {
    @Binding var selectedTab: Int
    let transactionsSend: [Int] = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5]
    let transactionsReceive: [Int] = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5]

    var body: some View {
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
    }
}
