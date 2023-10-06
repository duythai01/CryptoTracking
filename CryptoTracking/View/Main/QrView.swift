//
//  QrView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI

struct QrView: View {
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            Text("Qr View")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
        }
    }
}

struct QrView_Previews: PreviewProvider {
    static var previews: some View {
        QrView()
    }
}
