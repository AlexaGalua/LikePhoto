//
//  LoginViewController.swift
//  LikePhoto
//
//  Created by A on 2/18/22.
//

import UIKit


final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var logNameTextField: UITextField!
    @IBOutlet private weak var logSurnameTextField: UITextField!
    @IBOutlet private weak var saveLoginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func buttonLoggedInTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        logNameTextField.layer.borderWidth = 0
        logNameTextField.layer.borderColor = UIColor.clear.cgColor
        
        guard let controller = storyBoard.instantiateViewController(withIdentifier: "ListingViewController") as? ListingViewController, logNameTextField.text?.isEmpty == false else {
            
            logNameTextField.layer.borderWidth = 1
            logNameTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if let name = logNameTextField.text {
            UserDefaults.standard.setValue(name, forKey: String.profileTitle)
        }
        
        present(controller, animated: true, completion: {
            UserDefaults.standard.setValue(true, forKey: String.isUserLoggedIn)
        })
    }
}

