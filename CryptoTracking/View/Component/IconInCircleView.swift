//
//  IconInCircleView.swift
//  CryptoTracking
//
//  Created by DuyThai on 04/10/2023.
//

import Foundation
import SwiftUI

struct IconInCircleView: View {
    var iconName: String
    var body: some View {
        Circle()
            .frame(width: 60, height: 60)
            .foregroundColor(Color(#colorLiteral(red: 0.6186000705, green: 0.1361145377, blue: 0.9404763579, alpha: 1)))
            .overlay(
                Image(systemName: iconName)
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
            )
    }
}
