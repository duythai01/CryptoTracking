//
//  NewsView.swift
//  CryptoTracking
//
//  Created by DuyThai on 23/11/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsView: View {
    
    let advertismentBanner = ["banner1", "banner2", "banner3", "banner4"]
    var imageHeight: CGFloat = 0

    @StateObject var viewModel = NewsViewModel()
    @EnvironmentObject var coordinator: Coordinator<AppRouter>
    @State var openSideMenu: Bool = true
    @State var newsType: String = "Lattest News"

    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            VStack (spacing: 16){
                HStack{
                    Button(action: {}, label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                    })
                    Spacer()
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                }

                HStack {
                    VStack(alignment: .leading) {
                        Text("NEWS")
                                .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Text("From all the over the world")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.top, 8)

                SearchField(searchQuery: $viewModel.searchText, texSize: 16, iconSize: 16)
                    .padding(.top, 8)


                ScrollView(.horizontal) {
                    HStack(spacing: 6) {
                        Button(action: {
                            newsType = "Lattest News"
                            viewModel.getArticles()
                        }, label: {
                            HStack(spacing: 2) {
                                Image(systemName: "newspaper.fill")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.green)
                                Text("Lattest News")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        })
                        .padding(.all, 4)
                        .background(RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.white.opacity(newsType == "Lattest News" ? 0.2 : 0)))

                        Button(action: {
                            newsType = "Crypto News"
                        }, label: {
                            HStack(spacing: 2) {
                                Image(systemName: "bitcoinsign.circle.fill")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.yellow)
                                Text("Crypto News")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        })
                        .background(RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.white.opacity(newsType == "Crypto News" ? 0.2 : 0)))

                        Button(action: {
                            newsType = "News Archive"
                        }, label: {
                            HStack(spacing: 2) {
                                Image(systemName: "archivebox.fill")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.red.opacity(0.7))
                                Text("News Archive")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        })
                        .background(RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.white.opacity(newsType == "News Archive" ? 0.2 : 0)))

                        Button(action: {
                            newsType = "News Sources"
                        }, label: {
                            HStack(spacing: 2) {
                                Image(systemName: "doc.richtext.fill")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.blue)
                                Text("News Sources")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        })
                        .background(RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.white.opacity(newsType == "News Sources" ? 0.2 : 0)))
                        Spacer()

                    }
                }


                LoadingView(isHidden: $viewModel.isHiddenLoadNews, content: listNews) 
                Spacer()
            }
            .padding(.horizontal, 16)

        }
        .navigationTitle(Text("NEWS"))
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
        .onAppear {
            viewModel.getArticles()
        }
    }
}

extension NewsView {
    var listNews: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(viewModel.articlesDisplay) { article in

                    ArticleView(article: article)
                        .onTapGesture {
                            coordinator.show(.newsDetail(url: article.link ?? ""), isNavigationBarHidden: false)
                        }
                }
            }
        }
    }
}
extension NewsView {
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

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

enum DragState {
    case inactive
    case dragging(translation: CGSize)

    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }

    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}
