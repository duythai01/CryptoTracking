//
//  SceneDelegate.swift
//  CryptoTracking
//
//  Created by DuyThai on 02/11/2023.
//

import Foundation
import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    private var coordinator: Coordinator<AppRouter>!
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "appTrackingFirstLaunch")
        if !isFirstLaunch {
            UserDefaults.standard.set(true, forKey: "appTrackingFirstLaunch")
            coordinator = .init(startingRoute: .onboarding)
        } else {
            coordinator = .init(startingRoute: .appView)

        }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        UINavigationBar.appearance().tintColor = .white
        window?.overrideUserInterfaceStyle = .dark

        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}
