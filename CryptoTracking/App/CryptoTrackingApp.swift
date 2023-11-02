//
//  CryptoTrackingApp.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI

struct CryptoTrackingAppView: View {
    let persistenceController = PersistenceController.shared

    var body: some View {
            AppNavigationView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)

            }
    }
}


struct AppNavigationView<Content>: View where Content: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationView {
            content
                .navigationViewStyle(.automatic)
                .foregroundColor(.white)
        }
    }
}
