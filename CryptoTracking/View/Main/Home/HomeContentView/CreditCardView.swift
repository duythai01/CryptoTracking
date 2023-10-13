//
//  CreditCardView.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation
import SwiftUI

struct CreditCardView: View {
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                HStack {
                    Text("CURRENT BALANCE")
                        .font(.system(size: 20, weight: .thin))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                HStack {
                    Text("$ 9999.99")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                }.padding(.horizontal, 16)
                    .padding(.top, 6)

                Spacer(minLength: 12)
                GeometryReader { geometry in
                    HStack {
                        Text("0x111CecD9618D45Cb0f94fdb4801D01c91bBAF0Ba")
                            .font(.system(size: 14, weight: .medium))
                            .frame(width: geometry.size.width / 1.8)
                            .lineLimit(1)
                            .truncationMode(.middle)
                            .foregroundColor(.white)

                        Image(systemName: "rectangle.on.rectangle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                        Spacer()
                    }
                }.padding(.horizontal, 16)
            }
            Image("icon_money_bag")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6421564817, green: 0.04904890805, blue: 0.9898528457, alpha: 1)), Color(#colorLiteral(red: 0.3530189991, green: 0.4136217237, blue: 0.9337115884, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.8479173779, blue: 0.8667754531, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(16)
        .frame(maxHeight: UIScreen.main.bounds.size.height / 7)
        .padding(.horizontal, 16)

    }
}

