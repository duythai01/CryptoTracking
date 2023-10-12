//
//  ContentView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var tabBarSelected: MainTabBar = .home

    init () {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack {
            TabView(selection: $tabBarSelected)  {
                ForEach(MainTabBar.allCases, id: \.rawValue) { tab in
                    switch tab {
                    case .home:
                        HomeView().tag(tab)
                    case .history:
                        HistoryView().tag(tab)
                    case .qr:
                         QrView().tag(tab)
                    case .market:
                         MarketView().tag(tab)
                    case .setting:
                         SettingView().tag(tab)
                    }
                }
            }

            VStack {
                Spacer()
                TabarCustom(tabBarSelected: $tabBarSelected)
            }

        }.ignoresSafeArea()
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() }
}
