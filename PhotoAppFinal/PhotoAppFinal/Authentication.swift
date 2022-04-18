//
//  Authentication.swift
//  PhotoAppFinal
//
//  Created by A on 4/18/22.
//

import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated = false
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
}
