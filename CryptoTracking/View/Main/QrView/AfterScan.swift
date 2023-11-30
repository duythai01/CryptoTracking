//
//  AfterScan.swift
//  CryptoTracking
//
//  Created by DuyThai on 27/11/2023.
//

import Foundation
import SwiftUI
import WebKit

struct AfterScanView: View {
    let url: String
    let tilte: String
    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            WebView(urlString: url)
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationTitle(Text(tilte))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AfterScanView_Previews: PreviewProvider {
    static var previews: some View {
        AfterScanView(url: "https://www.gate.io/web3", tilte: "PAYMENT")
    }
}
