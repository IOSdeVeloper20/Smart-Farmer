//
//  SignUpVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 10/04/2023.
//

import UIKit

class SignUpVC: UIViewController {
    
//MARK:IBOutlets
    
    @IBOutlet weak var signUpEmailTF: UITextField!
    @IBOutlet weak var signUpPasswordTF: UITextField!
    @IBAction func signUpButton(_ sender: UIButton) {
    }
    @IBAction func signUpVCLoginButton(_ sender: UIButton) {
        let signUpToLogIn = (storyboard?.instantiateViewController(identifier: C.logInVC))!
        navigationController?.pushViewController(signUpToLogIn, animated: true)
    }
    
//MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
