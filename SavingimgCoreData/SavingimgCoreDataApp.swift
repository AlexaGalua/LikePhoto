//
//  SavingimgCoreDataApp.swift
//  SavingimgCoreData
//
//  Created by A on 4/19/22.
//

import SwiftUI
import Firebase

@main
struct LogiScreenApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    // описывается представление нашего кода
    //    прописываем объект среды в наше представление кода
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            LoginView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


