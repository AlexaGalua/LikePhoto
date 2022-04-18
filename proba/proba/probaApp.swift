//
//  probaApp.swift
//  proba
//
//  Created by A on 4/18/22.
//

import SwiftUI

@main
struct probaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
