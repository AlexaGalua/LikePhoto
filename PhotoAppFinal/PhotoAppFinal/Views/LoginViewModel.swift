//
//  LoginViewModel.swift
//  PhotoAppFinal
//
//  Created by A on 4/18/22.
//

import Foundation
import UIKit

class LoginViewModel: ObservableObject {
    @Published var credentials = Credentials()
    @Published var showProgressView = false
    
    var loginDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func login(completion: @escaping (Bool) -> Void) {
     showProgressView = true
        APIService.shared.login(credentials: credentials) { [unowned self](result:Result<Bool, APIService.APIError>) in
            showProgressView = false
            switch result {
            case .success:
                completion(true)
            case .failure:
                credentials = Credentials()
                completion(false)
            }
        }
    }
}
