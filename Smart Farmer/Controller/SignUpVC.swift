//
//  SignUpVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 10/04/2023.
//

import UIKit
import Firebase

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    //MARK:IBOutlets
    
    @IBOutlet weak var signUpEmailTF: UITextField!
    @IBOutlet weak var signUpPasswordTF: UITextField!
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        if let email = signUpEmailTF.text, let password = signUpPasswordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    
                    // Show a error message
                    let successAlert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    self.present(successAlert, animated: true, completion: nil)
                    
                    // Dismiss the alert after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        UIView.animate(withDuration: 0.5, animations: {
                            successAlert.view.alpha = 0.0
                        }) { _ in
                            successAlert.dismiss(animated: true, completion: nil)
                        }
                    }
                } else {
                    //if signed up correctly then instantiate tab bar controller (AppTB)
                    let signToTabBar = (self.storyboard?.instantiateViewController(withIdentifier: Constants.tabBar))!
                    signToTabBar.modalPresentationStyle = .fullScreen
                    signToTabBar.modalTransitionStyle = .flipHorizontal
                    self.present(signToTabBar, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func signUpVCLoginButton(_ sender: UIButton) {
        let signUpToLogIn = LogInVC.instatiate()
        navigationController?.pushViewController(signUpToLogIn, animated: true)
    }
    
    //MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpEmailTF.delegate = self
        signUpPasswordTF.delegate = self
        
        keyboardRecognizer()
    }
    
    //MARK: Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == signUpEmailTF {
            //when next is pressed foucus on passwordTF
            signUpPasswordTF.becomeFirstResponder()
        } else if textField == signUpPasswordTF {
            //when done is pressed dismiss keyboard
            textField.resignFirstResponder()
        }
        return true
    }
    
    func keyboardRecognizer() {
        // Add a gesture recognizer to dismiss the keyboard when tapped outside the text fields
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // Function to dismiss the keyboard when tapped outside the text fields
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
