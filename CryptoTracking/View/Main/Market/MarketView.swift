//
//  MarketView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI

struct MarketView: View {
    @StateObject private var viewModel = MarketViewModel()
    
    let testListMarket = [
        MarketViewItem(name: "Pancake swap", image: Image("ic_bitcoin"), link: "https://www.youtube.com/watch?v=j__Q13iAxNk"),
        MarketViewItem(name: "Pancake swap", image: Image("ic_bitcoin"), link: "https://www.youtube.com/watch?v=j__Q13iAxNk"),
        MarketViewItem(name: "Pancake swap", image: Image("ic_bitcoin"), link: "https://www.youtube.com/watch?v=j__Q13iAxNk"),
        MarketViewItem(name: "Pancake swap", image: Image("ic_bitcoin"), link: "https://www.youtube.com/watch?v=j__Q13iAxNk"),
    ]
    var body: some View {
        ZStack {
                Color.theme.mainColor.ignoresSafeArea()
                VStack(spacing: 26) {
                    Text("NFT Market")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold))
                    SearchField(searchQuery: $viewModel.searchText, texSize: 16, iconSize: 20)
                        .padding(.horizontal, 16)
                    LoadingView(isHidden: $viewModel.isHiddenLoading, content:
                        ScrollView(.vertical) {
                            LazyVStack(alignment: .center, spacing: 20) {
                                buildMarketList(sectionLabel: "Top NFT Marketplace", assetPlatforms: viewModel.assetPlatformDisplay)
                                buildMarketList(sectionLabel: "Other", assetPlatforms: viewModel.assetPlatformDisplay)

                            }
                        })
                    Spacer()

            }

        }
        .ignoresSafeArea(.keyboard)
        .onAppear{
            viewModel.getAssetPlatForm()
        }
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
    }

    func buildMarketList(sectionLabel: String, assetPlatforms: [AssetPlatformElement]) -> some View {
        return VStack (spacing: 16){
            if !assetPlatforms.isEmpty {
                HStack {
                    Text(sectionLabel)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold))
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .font(.system(size: 16, weight: .bold))
                            .frame(width: 20, height: 14)
                            .foregroundColor(.white)
                    })
                }}
            ForEach(assetPlatforms) { platform in
                HStack {
                    Circle()
                        .frame(width: 46, height: 46)
                        .overlay(
                            Image(platform.img ?? "")
                                .resizable()
                                .scaledToFit()
                        )
                        .padding(.vertical, 8)
                        .padding(.leading, 8)
                    VStack(alignment: .leading) {
                        Text(platform.name ?? "")
                            .foregroundColor(.white)
                        Spacer(minLength: 6)
                            .font(.system(size: 16, weight: .bold))
                        Text(platform.shortname ?? "")
                            .foregroundColor(.white.opacity(0.5))
                            .font(.system(size: 14))

                    }
                    .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.004149777324, green: 0.05499508851, blue: 0.269183639, alpha: 1)), Color(#colorLiteral(red: 0.004149777324, green: 0.05499508851, blue: 0.269183639, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                  )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.purple, lineWidth: 0)
                )
                .shadow(color: .white,radius: 2)

            }
        }
        .padding(.horizontal, 16)

    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
    }
}

struct MarketViewItem: Identifiable {
    let id = UUID()
    let name: String
    let image: Image
    let link: String
}

extension UIApplication {
    func dismissKeyboard() {
           self.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
        }
}


