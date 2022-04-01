//
//  LoginViewController.swift
//  LikePhoto
//
//  Created by A on 2/18/22.
//

import UIKit


final class LoginViewController: UIViewController {
    @IBOutlet private weak var logInNameTextField: UITextField!
    @IBOutlet private weak var loginSurnameTextField: UITextField!
    @IBOutlet private weak var saveLoginButton: UIButton!
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func buttonLoggedInTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        logInNameTextField.layer.borderWidth = 0
        logInNameTextField.layer.borderColor = UIColor.clear.cgColor
        
        guard let controller = storyBoard.instantiateViewController(withIdentifier: "ListingViewController") as? ListingViewController, logInNameTextField.text?.isEmpty == false else {
            
            logInNameTextField.layer.borderWidth = 1
            logInNameTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if let name = logInNameTextField.text {
            UserDefaults.standard.setValue(name, forKey: String.profileTitle)
        }
        
        present(controller, animated: true, completion: {
            UserDefaults.standard.setValue(true, forKey: String.isUserLoggedIn)
        })
    }
}
