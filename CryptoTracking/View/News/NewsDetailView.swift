//
//  NewsDetailView.swift
//  CryptoTracking
//
//  Created by DuyThai on 26/11/2023.
//

import Foundation
import SwiftUI
import WebKit

struct NewsDetailView: View {
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

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView(url: "https://polygon.technology/polygon-pos", tilte: "News")
    }
}
