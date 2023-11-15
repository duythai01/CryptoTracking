//
//  MarketDetailView.swift
//  CryptoTracking
//
//  Created by DuyThai on 14/11/2023.
//

import SwiftUI
import WebKit

struct MarketDetailView: View {
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

struct MarketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MarketDetailView(url: "https://polygon.technology/polygon-pos", tilte: "Klaytn")
    }
}


struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
                    print("Start loading")
                }

                // Handle the finish of navigation
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("Finish loading")
        }

    }
}
