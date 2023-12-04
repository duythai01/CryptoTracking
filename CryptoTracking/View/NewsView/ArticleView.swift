//
//  ArticleView.swift
//  CryptoTracking
//
//  Created by DuyThai on 01/12/2023.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
struct ArticleView: View {
    var article: ResultArticles
    var body: some View {
        var author = (article.pubDate ?? "") + ", by" + (article.creator?[0] ?? "")

        return HStack {
            ArticleImage(url: article.imageURL ?? "")
            ArticleDetailsView(article: article, author: author)
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}


struct ArticleImage: View {
    let url: String
    var body: some View {
        WebImage(url: URL(string: url))
            .resizable()
            .frame(width: UIScreen.main.bounds.width / 4.6, height: UIScreen.main.bounds.width / 4.6)
            .scaledToFill()
            .cornerRadius(12)
    }
}

struct ArticleDetailsView: View {
    var article: ResultArticles
    var author: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title ?? "")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .lineLimit(1)

            Text(author)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.white.opacity(0.8))
                .lineLimit(1)

            Text(article.description ?? "")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.white.opacity(0.7))
                .padding(.top, 2)
                .lineLimit(3)

            Spacer()
        }
        Spacer()
    }
}
