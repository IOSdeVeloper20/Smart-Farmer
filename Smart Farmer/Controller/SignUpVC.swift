//
//  SignUpVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 10/04/2023.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    //MARK:IBOutlets
    
    @IBOutlet weak var signUpEmailTF: UITextField!
    @IBOutlet weak var signUpPasswordTF: UITextField!
    
    @IBAction func signUpButton(_ sender: UIButton) {
   
        //validate fields
        if let email = signUpEmailTF.text, let password = signUpPasswordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    //if signed up correctly then instantiate tab bar controller (AppTB)
                    self.instantiateTabBarFromSignup()
                }
            }
        }
        //create the user
        
        //transition to home screen
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
        
    }
    
    //MARK: Functions
    func validateFields() -> String? {
        
        //check all fields are filled
        if (signUpEmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            signUpPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            return "Empty Fields"
        }
        return nil
    }
    
    func instantiateTabBarFromSignup() {
        let signToTabBar = (storyboard?.instantiateViewController(withIdentifier: Constants.tabBar))!
        signToTabBar.modalPresentationStyle = .fullScreen
        signToTabBar.modalTransitionStyle = .flipHorizontal
        present(signToTabBar, animated: true, completion: nil)
    }
}
