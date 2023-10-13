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
                         Text("Search or enter website url")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.gray.opacity(0.7))
                     }
                TextField("", text: $searchQuery) {
                    UIApplication.shared.endEditing()

                }
                    .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)

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
