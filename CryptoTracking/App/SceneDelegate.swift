//
//  SceneDelegate.swift
//  CryptoTracking
//
//  Created by DuyThai on 02/11/2023.
//

import Foundation
import SwiftUI
public enum EntryRouter: NavigationRouter {
    case appView

    public var transition: NavigationTranisitionStyle {
        switch self {
        case .appView:
            return .push
        }
    }

    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .appView:
            ContentView()
        }
    }
}


final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    private let coordinator: Coordinator<AppRouter> = .init(startingRoute: .appView)
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        UINavigationBar.appearance().tintColor = .white
        window?.overrideUserInterfaceStyle = .dark

        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}
