//
//  Setting.swift
//  CryptoTracking
//
//  Created by DuyThai on 13/10/2023.
//

import Foundation
import SwiftUI

enum SettingSection: CaseIterable {
    case edit
    case manage
    case setting
    case premium
    case other

    var items: [SettingFunc] {
        switch self {
        case .edit:
            return [.setPhoto, .setUserName]
        case .manage:
            return [.activityHistory, .device]
        case .setting:
            return [.notificationAndSound, .privacyAndSecurity, .dataAndStorage, .appearance, .powerSaving, .language]
        case .premium:
            return [.premium]
        case .other:
            return [.ask, .faq, .feature]
        }
    }
}

enum SettingFunc: CaseIterable {
    case setPhoto
    case setUserName
    case activityHistory
    case device
    case notificationAndSound
    case privacyAndSecurity
    case dataAndStorage
    case appearance
    case powerSaving
    case language
    case premium
    case ask
    case faq
    case feature

    var displayName: String {
        switch self {
        case .setPhoto:
            return "Set Profile photo"
        case .setUserName:
            return "Set Username"
        case .activityHistory:
            return "Recent activity"
        case .device:
            return "Device"
        case .notificationAndSound:
            return "Notifications and Sounds"
        case .privacyAndSecurity:
            return "Privacy and Security"
        case .dataAndStorage:
            return "Data and Storage"
        case .appearance:
            return "Appearance"
        case .powerSaving:
            return "Power Saving"
        case .language:
            return "Language"
        case .premium:
            return "Get Premium"
        case .ask:
            return "Ask a Question"
        case .faq:
            return "FAQ"
        case .feature:
            return "App Features"
        }
    }

    var displayIcon: Image {
        switch self {
        case .setPhoto:
            return Image(systemName: "camera.fill")
        case .setUserName:
            return Image(systemName: "pencil.and.ellipsis.rectangle")
        case .activityHistory:
            return Image(systemName: "gobackward")
        case .device:
            return Image(systemName: "macbook.and.iphone")
        case .notificationAndSound:
            return Image(systemName: "bell.badge.fill")
        case .privacyAndSecurity:
            return Image(systemName: "lock.fill")
        case .dataAndStorage:
            return Image(systemName: "square.stack.3d.up.fill")
        case .appearance:
            return Image(systemName: "circle.lefthalf.filled")
        case .powerSaving:
            return Image(systemName: "battery.25")
        case .language:
            return Image(systemName: "network")
        case .premium:
            return Image(systemName: "star.circle.fill")
        case .ask:
            return Image(systemName: "ellipsis.message.fill")
        case .faq:
            return Image(systemName: "questionmark.circle.fill")
        case .feature:
            return Image(systemName: "lightbulb.fill")
        }
    }

    var iconBackgroundColor: Color {
        switch self {
        case .setPhoto:
            return Color(#colorLiteral(red: 0, green: 0.8479173779, blue: 0.8667754531, alpha: 1))
        case .setUserName:
            return Color(#colorLiteral(red: 0.6421564817, green: 0.04904890805, blue: 0.9898528457, alpha: 1))
        case .activityHistory:
            return Color(#colorLiteral(red: 0.4711023047, green: 0.7955729365, blue: 0.2796118028, alpha: 1))
        case .device:
            return Color(#colorLiteral(red: 1, green: 0.5418865085, blue: 0.2282280028, alpha: 1))
        case .notificationAndSound:
            return Color(#colorLiteral(red: 0.8629416227, green: 0.09748800844, blue: 0.04347782582, alpha: 1))
        case .privacyAndSecurity:
            return Color.gray
        case .dataAndStorage:
            return Color(#colorLiteral(red: 0.2053279579, green: 1, blue: 0.1866790652, alpha: 1))
        case .appearance:
            return Color(#colorLiteral(red: 0.1677019596, green: 0.3749371469, blue: 1, alpha: 1))
        case .powerSaving:
            return Color(#colorLiteral(red: 1, green: 0.5572036505, blue: 0.2191196382, alpha: 1))
        case .language:
            return Color.purple
        case .premium:
            return  Color(#colorLiteral(red: 1, green: 0.5205873124, blue: 0.9142442057, alpha: 1))
        case .ask:
            return Color(#colorLiteral(red: 1, green: 0.626185889, blue: 0.1080223526, alpha: 1))
        case .faq:
            return Color(#colorLiteral(red: 0.3880109242, green: 0.5663196199, blue: 1, alpha: 1))
        case .feature:
            return Color(#colorLiteral(red: 0.01828966004, green: 0.4316078911, blue: 0.07015741416, alpha: 1))
        }
    }
}
