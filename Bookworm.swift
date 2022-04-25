//
//  Bookworm.swift
//  SavingimgCoreData
//
//  Created by Space on 4/20/22.
//

struct BookwormApp: App {

    var body: some View {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext) // <- and here <-
        }
    }
}
