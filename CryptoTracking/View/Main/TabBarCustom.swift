//
//  TabBarCustom.swift
//  CryptoTracking
//
//  Created by DuyThai on 04/10/2023.
//

import Foundation
import SwiftUI

struct TabarCustom: View {
    @Binding var tabBarSelected: MainTabBar
    var body: some View {
        HStack(
            alignment: .center
        ) {
            ForEach(MainTabBar.allCases, id: \.rawValue) { tab in
                Spacer()
                if tab == .qr {
                    IconInCircleView(iconName: tab.icon).onTapGesture {
                        withAnimation(.easeIn(duration: 0.2)){
                            tabBarSelected = tab
                        }
                    }

                } else {
                    Image(systemName: tab.icon).foregroundColor(tabBarSelected == tab ? .tabBarSelected : .gray)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.2)){
                                tabBarSelected = tab
                            }
                        }
                }
                Spacer()

            }
        }.frame(width: nil, height: 80
                , alignment: .top)
        .padding(.top, 8)
        .background(Color.tabBarBackground)
    }
}

