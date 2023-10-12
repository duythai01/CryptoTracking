//
//  SettingView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()
            Text("Setting View")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold))
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
