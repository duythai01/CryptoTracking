//
//  BottomSheetCustom.swift
//  CryptoTracking
//
//  Created by DuyThai on 30/10/2023.
//

import Foundation
import SwiftUI

enum BottomSheetViewMode: Equatable {
    case full
    case half
    case quarter
    case custom(heightRatio: CGFloat)
    case constantPadding(topPading: CGFloat)
    case none
}

struct BottomSheetView<Content: View>: View {
    let content: () -> Content
    let bottomSheetViewMode: Binding<BottomSheetViewMode>

    init( mode: Binding<BottomSheetViewMode>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.bottomSheetViewMode = mode
    }

    private func caculatorOffSet() -> CGFloat {
        switch bottomSheetViewMode.wrappedValue {
        case .full:
            return UIScreen.main.bounds.height
        case .half:
            return UIScreen.main.bounds.height / 2
        case .quarter:
            return UIScreen.main.bounds.height / 3
        case .custom(let heightRatio):
            return UIScreen.main.bounds.height * heightRatio
        case .constantPadding(let topPadding):
            return UIScreen.main.bounds.height - topPadding
        case .none:
            return 0
        }
    }

    var body: some View {
        content()
            .offset(y: UIScreen.main.bounds.height - caculatorOffSet())
            .padding(.bottom, bottomSheetViewMode.wrappedValue ==  .none ? 0 : UIScreen.main.bounds.height - caculatorOffSet())
            .edgesIgnoringSafeArea(.bottom)

    }

}
