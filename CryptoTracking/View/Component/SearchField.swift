//
//  SearchField.swift
//  CryptoTracking
//
//  Created by DuyThai on 09/10/2023.
//

import Foundation
import SwiftUI

struct SearchField: View {
    @Binding var searchQuery: String
    var placeHolder: String?
    var texSize: CGFloat
    var iconSize: CGFloat
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .font(.system(size: iconSize, weight: .bold))
                .foregroundColor(.white)
                .frame(width: iconSize, height: iconSize)
                .padding(10)

            ZStack(alignment: .leading) {
                if searchQuery == "" {

                    Text(placeHolder ?? "")
                        .font(.system(size: texSize, weight: .medium))
                        .foregroundColor(Color.gray.opacity(0.7))
                }

                TextField("", text: $searchQuery) {
                    UIApplication.shared.dismissKeyboard()

                }
                .font(.system(size: texSize, weight: .medium))
                .foregroundColor(.white)
                HStack {

                    Spacer()
                    if searchQuery != "" {
                        Button(action: {
                            withAnimation {
                                searchQuery = ""
                            }
                        }, label: {
                            Image(systemName: "multiply.circle.fill")
                                .font(.system(size: texSize, weight: .medium))
                                .foregroundColor(.purple)

                        })
                        .padding(.horizontal, 16)

                    }

                }


            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white.opacity(0.5), lineWidth: 1.5)
        )
        .transition(.scale)
    }
}
