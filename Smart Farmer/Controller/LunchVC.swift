//
//  LuchVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 04/04/2023.
//

import UIKit

class LunchVC: UIViewController {
    
//MARK: IBOutlets
    @IBOutlet weak var SloganLabel: UILabel!
    
    @IBAction func LunchVCsignUpButton(_ sender: UIButton) {
        let sign = (storyboard?.instantiateViewController(withIdentifier: C.onBoardingVC))!
        sign.modalPresentationStyle = .fullScreen
        present(sign, animated: true,completion: nil)
    }
    
    @IBAction func LunchVCLogInButton(_ sender: UIButton) {
        let login = (storyboard?.instantiateViewController(withIdentifier: C.logInVC))!
        navigationController?.pushViewController(login, animated: true)
    }
    
//MARK: Variables
    var counter: Double = 0.0
    
//MARK: Life Cycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SloganLabel.text = ""
        var charIndex = 0.0
        let slogan = C.slogan
        
        for character in slogan {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false){ (timer) in
                self.SloganLabel.text?.append(character)
            }
            charIndex += 1
        }
    }
}
