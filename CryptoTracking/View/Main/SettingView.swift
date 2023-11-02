//
//  SettingView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI

struct SettingView: View {
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            ScrollView(.vertical) {

                VStack(spacing: 22) {
                    SettingHeaderView()
                    ForEach(SettingSection.allCases, id: \.self) { section in
                        buildSettingSection(section: section.items)

                    }.padding(.horizontal, 16)

                    Spacer()
                }
            }
            .onChange(of: scrollOffset) { newValue in
                // The scroll offset has changed
                print("Scroll offset: \(scrollOffset)")
            }
            .onAppear {
                print("On Appear")
            }

            VStack {
                HStack {
                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: "qrcode")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                        }
                    })
                    Spacer()
                    Button("Edit", action: {})
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
                Spacer()
            }
        }
    }

    func buildSettingSection(section: [SettingFunc]) -> some View {
        VStack(spacing: 12) {
            ForEach(0..<section.count, id: \.self) { index in
                ItemSetting(image: section[index].displayIcon, label: section[index].displayName, iconBackgroundColor: section[index].iconBackgroundColor) {
                    print("action")
                }.padding(.horizontal, 16)
                if index != section.count - 1 {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.theme.mainColor)
                        .padding(.leading, 60)
                }
            }
        }
        .listStyle(.inset)
        .padding(.vertical, 16)
        .background(Color.white.opacity(0.2))
        .cornerRadius(14)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct SettingHeaderView: View {
    var body: some View {
        VStack {
            Circle()
                .frame(width: 80, height: 80)

                .overlay(
                    Image("ic_batman")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.white))

            VStack(alignment: .center,spacing: 2) {
                Text("Jhon Smith")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                VStack {
                    HStack {
                        Spacer()
                        Text("0x111CecD9618D45Cb0f94fdb4801D01c91bBAF0Ba")
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: UIScreen.main.bounds.size.width / 3)
                            .lineLimit(1)
                            .truncationMode(.middle)
                            .foregroundColor(.gray)

                        Image(systemName: "rectangle.on.rectangle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white.opacity(0.8))
                            .frame(width: 20, height: 20)
                        Spacer()
                    }
                    Text(verbatim: "jhohnsmith123@gmail.com")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                }
            }

        }
    }
}

struct ItemSetting: View {
    var image: Image
    var label: String
    var iconBackgroundColor: Color
    var action: () -> Void
    var body: some View {
        Button(action: {action()}, label: {
            HStack {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .font(.system(size: 18, weight: .heavy))
                    .foregroundColor(.white)
                    .padding(6)
                    .background(iconBackgroundColor)
                    .cornerRadius(6)

                Text(label)
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .medium))
                Spacer()

                Image(systemName: "chevron.up")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 16, height: 20)
                    .rotationEffect(Angle(degrees: 90))

            }
        })
    }
}
