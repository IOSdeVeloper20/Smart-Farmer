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
        //if signed up correctly then instantiate tab bar controller (AppTB)
        let signToTabBar = (storyboard?.instantiateViewController(withIdentifier: Constants.tabBar))!
        signToTabBar.modalPresentationStyle = .fullScreen
        signToTabBar.modalTransitionStyle = .flipHorizontal
        present(signToTabBar, animated: true, completion: nil)
        //navigationController?.pushViewController(signToTabBar, animated: true)
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
}
