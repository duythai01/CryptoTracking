//
//  Coordinator.swift
//  CryptoTracking
//
//  Created by DuyThai on 02/11/2023.
//

import Foundation
import SwiftUI
public enum NavigationTranisitionStyle {
    case push
    case presentModally
    case presentFullscreen
}

public protocol NavigationRouter {

    associatedtype V: View

    var transition: NavigationTranisitionStyle { get }

    /// Creates and returns a view of assosiated type
    ///
    @ViewBuilder
    func view() -> V
}


open class Coordinator<Router: NavigationRouter>: ObservableObject {

    public let navigationController: UINavigationController
    public let startingRoute: Router?

    public init(navigationController: UINavigationController = .init(), startingRoute: Router? = nil) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
    }

    public func start( ) {
        guard let route = startingRoute else { return }
        show(route)
    }

    public func show(_ route: Router, animated: Bool = true, isNavigationBarHidden: Bool = true) {
        let view = route.view()
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        switch route.transition {
        case .push:
            navigationController.isNavigationBarHidden = isNavigationBarHidden
            navigationController.pushViewController(viewController, animated: animated)
        case .presentModally:
            viewController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated)
        case .presentFullscreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
        }
    }

    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }

    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }

    open func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: true) { [weak self] in
            /// because there is a leak in UIHostingControllers that prevents from deallocation
            self?.navigationController.viewControllers = []
        }
    }
}
