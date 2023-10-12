//
//  HistoryHeaderView.swift
//  CryptoTracking
//
//  Created by DuyThai on 09/10/2023.
//

import Foundation
import SwiftUI

struct HistoryHeaderView : View {
    @Binding var searchQuery: String
    @State var animation: Bool = false
    var body: some View {
        VStack {
            Text("History" )
                .font(.system(size: 28
                              , weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .frame(width: nil)
        }
    }
}

