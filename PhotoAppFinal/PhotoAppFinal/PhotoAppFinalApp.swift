//
//  PhotoAppFinalApp.swift
//  PhotoAppFinal
//
//  Created by A on 4/18/22.
//

import SwiftUI

@main
struct PhotoAppFinalApp: App {
    @StateObject var authentication = Authentication()
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                ContentView()
                    .environmentObject(authentication)
                
            } else {
                LoginView()
                    .environmentObject(authentication)
            }
        }
    }
}
