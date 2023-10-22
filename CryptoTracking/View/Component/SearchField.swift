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
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFit()
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .padding(10)

            ZStack(alignment: .leading) {
                if searchQuery == "" {

                    Text(placeHolder ?? "")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.gray.opacity(0.7))
                }

                TextField("", text: $searchQuery) {
                    UIApplication.shared.endEditing()

                }
                .font(.system(size: 16, weight: .medium))
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
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.purple)

                        })
                        .padding(.horizontal, 16)

                    }

                }


            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white.opacity(0.5), lineWidth: 2)
        )
        .padding(.horizontal, 24)
        .transition(.scale)
    }
}
