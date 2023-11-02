//
//  FilterAndDatePicker.swift
//  CryptoTracking
//
//  Created by DuyThai on 09/10/2023.
//

import Foundation
import SwiftUI

struct FilterAndDatePicker: View {
    @Binding var dateSelection: Date
    @Binding var selection: FilterTransaction
    @Binding var isShowMenu: Bool
    @Binding var heightDropmenu: CGFloat

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    HStack {
                        Image("ic_filter")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.purple)

                        Text(selection.displayName)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width:  12 , height: 12)
                            .rotationEffect(Angle(degrees: isShowMenu ? -90 : 0))
                            .foregroundColor(.white)
                    }
                    .background(Color.theme.mainColor)
                    .onTapGesture {
                        withAnimation() {
                            isShowMenu.toggle()
                        }
                    }

                    Spacer()
                }

                DatePicker(selection: $dateSelection, in: ...Date(), displayedComponents: .date) {
                    Button(action: {}){
                    }
                }
                .datePickerStyle(.compact)
                .accentColor(.purple)
                .environment(\.colorScheme,.dark)
            }
            .padding(.horizontal, 16)
            if isShowMenu {
                GeometryReader { geometry in
                    HStack {
                        ScrollView{
                            LazyVStack(alignment: .leading, spacing: 2) {
                                ForEach(FilterTransaction.allCases) { item in
                                    HStack {
                                        Text(item.displayName)
                                            .foregroundColor( selection == item ? .purple : .white)
                                            .font(.system(size: 16, weight: .medium))
                                        .padding(.all, 8)
                                        Spacer()
                                        if selection == item {
                                            Image(systemName: "arrowtriangle.left.fill")
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                                .foregroundColor(.purple)
                                                .padding(.trailing, 8)
                                        }
                                    }
                                    .onTapGesture {
                                        selection = item
                                        isShowMenu = false
                                    }
                                }
                            }

                        }
                        .frame(width: 140)
                        .fixedSize(horizontal: true, vertical: true)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(Color.theme.mainColor.opacity(0.9))
                                .shadow(color: .white, radius: 2)
                    )
                        Spacer()
                    }
                    .onAppear {
                        heightDropmenu =  geometry.size.height
                    }
                    .padding(.horizontal, 20)

                }
            }

        }
        .zIndex(20)

    }
}

