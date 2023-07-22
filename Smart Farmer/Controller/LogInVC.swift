//
//  LogInVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 10/04/2023.
//

import UIKit
import Firebase

class LogInVC: UIViewController, UITextFieldDelegate {

//MARK: IBOulets
    @IBOutlet weak var logInEmailTF: UITextField!
    @IBOutlet weak var logInPasswordTF: UITextField!
    
    @IBAction func forgotPassButton(_ sender: UIButton) {
        if let email = logInEmailTF.text {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    print("Error sending password reset email: \(error.localizedDescription)")
                    // Show an error in alert message to the user
                    let failurAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    failurAlert.addAction(okAction)
                    self.present(failurAlert, animated: true, completion: nil)
                    
                    // Dismiss the alert after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        UIView.animate(withDuration: 0.5, animations: {
                            failurAlert.view.alpha = 0.0
                        }) { _ in
                            failurAlert.dismiss(animated: true, completion: nil)
                        }
                    }
                } else {
                    print("Password reset email sent successfully")
                    // Show a success message or navigate to a password reset confirmation screen
                    let successAlert = UIAlertController(title: "Success", message: "An email was sent to the provided mail", preferredStyle: .alert)
                    self.present(successAlert, animated: true, completion: nil)
                    
                    // Dismiss the alert after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        UIView.animate(withDuration: 0.5, animations: {
                            successAlert.view.alpha = 0.0
                        }) { _ in
                            successAlert.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        
        let loginToTabBar = (self.storyboard?.instantiateViewController(withIdentifier: Constants.tabBar))!
        loginToTabBar.modalPresentationStyle = .fullScreen
        loginToTabBar.modalTransitionStyle = .flipHorizontal
        self.present(loginToTabBar, animated: true, completion: nil)
        
        //validate user
//        if let email = logInEmailTF.text, let password = logInPasswordTF.text {
//            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//                if let e = error {
//                    print(e.localizedDescription)
//                    // Show a error message
//                    let successAlert = UIAlertController(title: "error", message: e.localizedDescription, preferredStyle: .alert)
//                    self.present(successAlert, animated: true, completion: nil)
//
//                    // Dismiss the alert after a delay
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                        UIView.animate(withDuration: 0.5, animations: {
//                            successAlert.view.alpha = 0.0
//                        }) { _ in
//                            successAlert.dismiss(animated: true, completion: nil)
//                        }
//                    }
//                } else {
//                    //check if logged in then instantiate tab bar controller (AppTB)
//                    let loginToTabBar = (self.storyboard?.instantiateViewController(withIdentifier: Constants.tabBar))!
//                    loginToTabBar.modalPresentationStyle = .fullScreen
//                    loginToTabBar.modalTransitionStyle = .flipHorizontal
//                    self.present(loginToTabBar, animated: true, completion: nil)
//                }
//            }
//        }
    }
    
//MARK: Variables
    
    var iconClick = false
    var imageIcon = UIImageView()
    let contentView = UIView()
    
//MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInEmailTF.delegate = self
        logInPasswordTF.delegate = self
        
        eyeIcon()
        keyboardRecognizer()
    }
    
//MARK: Functions
    
    func eyeIcon() {
        imageIcon.image = UIImage(systemName: "eye")
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye")!.size.width, height: (UIImage(systemName: "eye")?.size.height)!)
        
        imageIcon.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye")!.size.width, height: (UIImage(systemName: "eye")!.size.height))
        
        logInPasswordTF.rightView = contentView
        logInPasswordTF.rightViewMode = .always
        //adding tapping gesture to the image
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapgesture)
    }
    
    @objc func imageTapped(UITapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = UITapGestureRecognizer.view as! UIImageView
        
        if iconClick {
            iconClick = false
            tappedImage.image = UIImage(systemName: "eye")
            logInPasswordTF.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage.image = UIImage(systemName: "eye.slash")
            logInPasswordTF.isSecureTextEntry = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if  textField == logInEmailTF {
            // When the return key is pressed focus on passwordTF
             logInPasswordTF.becomeFirstResponder()
        } else if textField == logInPasswordTF {
            // When the done key is pressed will dismiss the keyboard,
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

