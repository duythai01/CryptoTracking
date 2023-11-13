//
//  LoadingView.swift
//  CryptoTracking
//
//  Created by DuyThai on 10/11/2023.
//

import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View  {

    @Binding var isHidden: Bool
    @State private var animateStrokeStart = false
    @State private var animateStrokeEnd = false
    @State private var isRotating = true
    let content: Content

    var body: some View {
        ZStack{
            content
            if !isHidden {
                Image("ic_launchscreen")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 26, height: 26)
                Circle()
                    .trim(from: animateStrokeStart ? 1/3 : 1/9, to: animateStrokeEnd ? 2/5 : 1)
                                .stroke(lineWidth: 3)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.purple)
                    .rotationEffect(.degrees(isRotating ? 360 : 0))
                    .onAppear() {

                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                        {
                            self.isRotating.toggle()
                        }

                        withAnimation(Animation.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true))
                        {
                            self.animateStrokeStart.toggle()
                        }

                        withAnimation(Animation.linear(duration: 1).delay(1).repeatForever(autoreverses: true))
                                       {
                                           self.animateStrokeEnd.toggle()
                                       }
                }
            }
        }
    }
}
