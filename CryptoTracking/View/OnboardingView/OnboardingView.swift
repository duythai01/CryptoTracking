//
//  SwiftUIView.swift
//  CryptoTracking
//
//  Created by DuyThai on 06/11/2023.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var coordinator: Coordinator<AppRouter>

    @State var currentPage: Int = 0

    private let pages = [
        OnboardingInf(title: "Your All-in-One Crypto Tracking App", description: "Welcome to CryptoTrack, the ultimate app for monitoring and managing your cryptocurrency investments right from your onboard screen! Whether you're a seasoned crypto enthusiast or just getting started, our user-friendly platform is designed to make tracking your crypto portfolio a breeze."),
        OnboardingInf(title: "Real-Time Portfolio Monitoring", description: "Stay up to date with your cryptocurrency holdings as our app provides real-time data on the performance of your assets. Keep an eye on your investments without the hassle of constant manual updates."),
        OnboardingInf(title: "Investment Diversification", description: "Asset managers strive to create diversified portfolios, spreading investments across various asset classes such as stocks, bonds, real estate, and alternative investments. Diversification helps to reduce risk and achieve a more balanced return."),
        OnboardingInf(title: "Resell or Trade NFTs", description: "If you choose to sell or trade your collected NFTs, you can list them for sale on the same NFT marketplaces or trade them with other collectors.\n\nRemember that the value of NFTs can be highly speculative, and it's essential to do your research, understand the terms and conditions of the NFT platforms, and exercise caution when investing in or trading NFTs. Also, different blockchains and platforms may have varying procedures, so be sure to familiarize yourself with the specific platform you're using."),
        OnboardingInf(title: "Historical Data and Charts", description: "Access historical price charts and market data to analyze the performance of your investments over time. Make data-driven decisions with ease."),
    ]
    var body: some View {
        ZStack {
            genBackgroundOnboarding(index: currentPage)
            VStack(alignment: .leading, spacing: 16) {
                Spacer()
                Text(pages[currentPage].title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Text(pages[currentPage].description)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white.opacity(0.6))
                HStack {
                    HStack {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Circle()
                                .frame(width: currentPage == index ? 4 : 6, height: currentPage == index ? 4 : 6)
                                .padding(.all,currentPage == index ? 3 : 0)
                                .foregroundColor(currentPage == index ? .black : .gray)
                                .background(Circle().foregroundColor(.white))
                                .onTapGesture {
                                    withAnimation {
                                        currentPage = index
                                    }
                                }

                        }
                    }
                    Spacer()
                    Button(action: {
                        if currentPage >= 4 {
                            coordinator.show(.appView)
                            
                        } else {
                            withAnimation {
                                currentPage += 1
                            }
                        }
                    }, label: {
                        if currentPage < 4 {
                            Image(systemName: "arrow.forward")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.black)
                                .padding(.all, 18)
                        } else {
                            Text("Get started")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                        }

                    })

                    .background(Capsule().foregroundColor(currentPage >= 4 ? .purple.opacity(0.7) : .white))
                }
            }
            .padding([.horizontal, .bottom], 16)
        }
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded({ value in
                                if value.translation.width < 0 {
                                    if currentPage < pages.count - 1 {
                                        withAnimation {
                                            currentPage += 1
                                        }
                                    }
                                }

                                if value.translation.width > 0 {
                                    if currentPage > 0  {
                                        withAnimation {
                                            currentPage -= 1
                                        }
                                    }

                                }

                            }))
    }
}

extension OnboardingView {
    @ViewBuilder
    func genBackgroundOnboarding(index: Int) -> some View {
        switch index {
        case 0:
            ZStack {
                Color.theme.mainColor.ignoresSafeArea()
                Image("unsplash1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 400, height: 400)
                    .offset(x: -100)
                HStack {
                    Spacer()

                    Image("unsplash2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)

                }
                Image("unsplash4")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .offset(x: 0, y: -200)

                VStack {
                    Image("unsplash3")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                    Spacer()
                }
                .offset(x: -200)
                Image("ic_3d_BTC")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .offset(.init(width: 30, height: -180))
                Image("ic_3d_shiba")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .offset(.init(width: 100, height: -200))
                Image("ic_3d_SOL")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .offset(.init(width: 40, height: -260))

                Image("ic_3d_BNB")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .offset(.init(width: 120, height: -320))

                Image("ic_3d_looksrare")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .offset(.init(width: 60, height: -300))

            }
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.white.opacity(0), .white.opacity(0), .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
            .transition(.fade.animation(.easeInOut(duration: 0.2)))
        case 1:
            ZStack {
                Color.theme.mainColor.ignoresSafeArea()
                VStack {
                    Image("3d_img_bg")
                        .resizable()
                        .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    .rotationEffect(Angle(degrees: 28))
                    .padding(.all, -32)
                    .background(
                        Circle()
                            .stroke(lineWidth: 1)
                            .foregroundColor(.white.opacity(0.3))
                            .padding(.all, 12)
                            .background(
                                Circle()
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.white.opacity(0.3))
                                    .padding(.all, 24)
                                    .background(
                                        Circle()
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(.white.opacity(0.3))
                                        .padding(.all, 36)
                                        .background(
                                            Circle()
                                                .stroke(lineWidth: 1)
                                                .foregroundColor(.white.opacity(0.3))
                                                .padding(.all, 48)
                                                .background(
                                                    Circle()
                                                        .stroke(lineWidth: 1)
                                                        .foregroundColor(.white.opacity(0.3))
                                                    )
                                            )
                                        )
                                )

                            )
                    Spacer()
                }
                .padding(.top, 32)

            }
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.white.opacity(0), .white.opacity(0), .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
            .transition(.fade.animation(.easeInOut(duration: 0.2)))

        case 2:
            ZStack {
                Color.theme.mainColor.ignoresSafeArea()
                VStack {
                    Image("3d_img_bg2")
                        .resizable()
                        .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 24, height: UIScreen.main.bounds.width)
                    Spacer()
                }.padding(.top, UIScreen.main.bounds.width / 3)

            }
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.white.opacity(0), .white.opacity(0), .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
            .transition(.fade.animation(.easeInOut(duration: 0.2)))

        case 3:
            ZStack {
                Color.theme.mainColor.ignoresSafeArea()
                VStack {
                    Image("3d_img_bg3")
                        .resizable()
                        .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 24, height: UIScreen.main.bounds.width)
                    Spacer()
                }

            }
            .overlay(
                LinearGradient(gradient: Gradient(colors: [ .theme.mainColor, .white.opacity(0), .white.opacity(0), .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
            .transition(.fade.animation(.easeInOut(duration: 0.2)))

        case 4:
            ZStack {
                Color.theme.mainColor.ignoresSafeArea()
                ZStack {
                    VStack {
                        Image("3d_img_41")
                            .resizable()
                        .frame(width: UIScreen.main.bounds.width - 24, height: UIScreen.main.bounds.width)

                        Spacer()
                    }
                    .padding(.top, -60)
                    .padding(.trailing, 26)
                    Image("3d_img_bg4")
                        .resizable()
                        .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 24, height: UIScreen.main.bounds.width)
                }
            }
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.white.opacity(0), .white.opacity(0), .black]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
            .transition(.fade.animation(.easeInOut(duration: 0.2)))

        default:
            EmptyView()
        }
    }
}

struct OnboardingInf {
    let title: String
    let description: String
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
