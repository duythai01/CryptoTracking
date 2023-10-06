//
//  TransactionView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI

struct TransactionView: View {
    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            Text("Transaction View")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
