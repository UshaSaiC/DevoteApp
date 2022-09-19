//
//  DevoteAppApp.swift
//  DevoteApp
//
//  Created by Usha Sai Chintha on 19/09/22.
//

import SwiftUI

@main
struct DevoteAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
