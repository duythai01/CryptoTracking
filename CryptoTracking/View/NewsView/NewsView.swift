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
    @State var widthSlideBarMin: CGFloat = 0
    @State var menuSelected: String = "Home"
    var body: some View {
        ZStack {

            SlideMenuView(selectedTab: $menuSelected, widthSlideBarMin: $widthSlideBarMin)
            ZStack {
                Color.theme.mainColor.ignoresSafeArea()
                VStack {
                    TabView(selection: $menuSelected) {
                        homeNewsView
                            .tag("Home")
                        markNewsView
                            .tag("Mark")
                        continueNewsView
                            .tag("Continue")
                        noteNewsView
                            .tag("Note")
                        settingNewsView
                            .tag("Setting")
                    }

                }
            }
            .offset(x: openSideMenu ? UIScreen.main.bounds.width / 3 + 16 : 0)
        }
        .navigationTitle(Text("NEWS"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(false)
        .navigationBarItems(leading: Button(action: {
            withAnimation() {
                openSideMenu.toggle()
            }
        },
         label: {
            VStack(spacing: 6) {
                Capsule()
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 30, height: 3)
                    .rotationEffect(Angle(degrees: openSideMenu ? -50 : 0))
                    .offset(x: openSideMenu ? 3 : 0, y: openSideMenu ? 10 : 0)

                VStack(spacing: 6){
                    Capsule()
                        .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 30, height: 3)
                    Capsule()
                        .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 30, height: 3)
                    .offset(y: openSideMenu ? -9 : 0)
                }
                .rotationEffect(Angle(degrees: openSideMenu ? 50 : 0))

            }
        }))
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

    var homeNewsView: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()

            VStack (spacing: 16){


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
            .padding(.top, 32)
        }
    }


    var markNewsView: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()

            VStack {
                Text("markNewsView")
                            .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
            }
            .padding(.top, 32)
        }
    }


    var continueNewsView: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()

            VStack {
                Text("continueNewsView")
                        .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.top, 32)
        }
    }


    var noteNewsView: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()

            VStack {
                Text("noteNewsView")
                        .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.top, 32)
        }
    }


    var settingNewsView: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()

            VStack {
                Text("notesettingNewsViewNewsView")
                        .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.top, 32)
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

struct SlideMenuView: View {
    @Binding var selectedTab: String
    @Binding var widthSlideBarMin: CGFloat
    @Namespace var animation
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.3899378609, green: 0.1823446642, blue: 0.5, alpha: 1)).ignoresSafeArea()
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    VStack {
                        Image("ic_batman")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                        .cornerRadius(35, corners: .allCorners)

                        VStack (alignment: .leading, spacing: 6) {
                            Text("Duy Thai")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            Button(action: {}, label: {
                                Text("View profile")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .opacity(0.7)
                            })
                        }

                    }
                    .padding()

                    VStack(alignment: .leading, spacing: 12) {
                        TabButtonView(image: Image(systemName: "house.fill"), title: "Home", selectedTab: $selectedTab, animation: animation)
                        TabButtonView(image: Image(systemName: "star.fill"), title: "Mark", selectedTab: $selectedTab, animation: animation)
                        TabButtonView(image: Image(systemName: "newspaper.fill"), title: "Continue", selectedTab: $selectedTab, animation: animation)
                        TabButtonView(image: Image(systemName: "note.text"), title: "Note", selectedTab: $selectedTab, animation: animation)
                        TabButtonView(image: Image(systemName: "gearshape.fill"), title: "Setting", selectedTab: $selectedTab, animation: animation)
                        Spacer()
                        TabButtonView(image: Image(systemName: "rectangle.portrait.and.arrow.forward.fill"), title: "Out", selectedTab: $selectedTab, animation: animation)
                    }
                }
                .frame( maxHeight: .infinity, alignment: .topLeading)
                Spacer()
            }
        }

    }
}

struct TabButtonView: View {
    var image: Image
    var title: String
    @EnvironmentObject var coordinator: Coordinator<AppRouter>

    @Binding var selectedTab: String

    var animation: Namespace.ID
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut){
                if title == "Out" {
                    coordinator.pop()
                } else {
                    selectedTab = title
                }
            }
        }, label: {
            HStack(spacing: 10){
                image
                    .font(.title2)

                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedTab == title ? .purple : .white)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(
                ZStack {
                    if selectedTab == title {
                        Color.white.opacity(selectedTab == title ? 1 : 0)
                            .cornerRadius(12, corners: [.topRight, .bottomRight])
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
        })
    }
}


