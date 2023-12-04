//
//  HomeHeaderView.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/10/2023.
//

import Foundation
import SwiftUI

extension HomeView {
    var headerView: some View {
        HStack {
            Button(action: {
                coordinator.show(.personal)
                coordinator.navigationController.isNavigationBarHidden = false

            }) {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(#colorLiteral(red: 0.6186000705, green: 0.1361145377, blue: 0.9404763579, alpha: 1)))
                    .overlay(
                        Image("ic_batman")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.white))
            }

            VStack(alignment: .leading,spacing: 2) {
                Text("Jhon Smith")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                Text("Welcome Back")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .medium))
            }
            Spacer()
            Button(action: {
            }) {
                Button(action: {
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white.opacity(0.1))
                            .overlay(
                                Image(systemName: "bell")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(Color.white)
                        )

                            Circle()
                            .frame(width: 13, height: 13)
                            .foregroundColor(.red)
                            .padding([.bottom, .leading], 22)
                    }
                }
            }

        }.frame(width: nil)
    }

}
