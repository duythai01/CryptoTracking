//
//  TextFieldLogin.swift
//  CryptoTracking
//
//  Created by DuyThai on 13/11/2023.
//

import Foundation
import SwiftUI
struct TextFieldLogin<Content>: View where Content: View {
    @Binding var text: String
    let placeHolder: String
    let image: Image
    let textView: Content
    var body: some View {
        HStack {
                image
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.purple)
                .background(Circle().foregroundColor(.white).padding(.all, 3))
            VStack {
                ZStack(alignment: .leading) {
                    if text == "" {

                        Text(placeHolder)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.gray.opacity(0.7))
                    }


                    textView

                    HStack {
                        Spacer()
                        if text != "" {
                            Button(action: {
                                text = ""
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.purple)

                            })
                            .padding(.horizontal, 16)

                        }

                    }


                }
                Color.white.frame(height: 2 / UIScreen.main.scale)
            }
            .padding(.horizontal, 6)
        }
    }
}
