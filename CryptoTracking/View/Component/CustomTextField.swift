//
//  CustomTextField.swift
//  CryptoTracking
//
//  Created by DuyThai on 01/11/2023.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    @Binding var onEditingChanged: Bool
    var body: some View {
        ZStack(alignment: .leading) {
            if text == "" {

                Text("0")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.gray.opacity(0.5))
            }

            TextField("", text: $text, onEditingChanged: { changed in
                onEditingChanged = changed
            })
            .keyboardType(.decimalPad)
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(.white.opacity(0.8))
            .accentColor(.white.opacity(0.8))
        }
    }
}
