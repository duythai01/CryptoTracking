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
