//
//  RotationBanner.swift
//  CryptoTracking
//
//  Created by DuyThai on 17/11/2023.
//

import Foundation
import SwiftUI
struct RotationBanner: View {
    @State private var selectedTabBanner: Int = 0
    let advertismentBanner = ["banner1", "banner2", "banner3", "banner4"]
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        TabView(selection: $selectedTabBanner) {
            ForEach(0..<advertismentBanner.count, id: \.self) { index in
                HStack {
                    Image(advertismentBanner[index])
                        .resizable()
                        .scaledToFill()
                }
                .tag(index)
            }

        }
        .frame(height: 130)
        .padding(.horizontal, 20)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onReceive(timer) { _ in
            selectedTabBanner = (selectedTabBanner + 1) % advertismentBanner.count
        }
    }
}
