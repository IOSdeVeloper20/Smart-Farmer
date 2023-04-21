//
//  LogInVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 10/04/2023.
//

import UIKit

class LogInVC: UIViewController {

//MARK: IBOulets
    @IBOutlet weak var logInEmailTF: UITextField!
    @IBOutlet weak var logInPasswordTF: UITextField!
    @IBAction func forgotPassButton(_ sender: UIButton) {
    }
    @IBAction func logInButton(_ sender: UIButton) {
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
        eyeIcon()
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
}