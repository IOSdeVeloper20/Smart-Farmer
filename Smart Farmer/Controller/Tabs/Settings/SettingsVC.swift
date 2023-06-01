//
//  SettingsVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 18/04/2023.
//

import UIKit

class SettingsVC: UIViewController {
    
//MARK: IBOutlets
    @IBAction func LogOutButton(_ sender: UIButton) {
        let loggedOut = (storyboard?.instantiateViewController(withIdentifier: Constants.lunchNC))!
        loggedOut.modalPresentationStyle = .fullScreen
        loggedOut.modalTransitionStyle = .coverVertical
        present(loggedOut, animated: true, completion: nil)
    }
    @IBOutlet weak var appearanceButtonImage: UIButton!
    @IBAction func AppearanceButton(_ sender: UIButton) {
        appearancePickUpView.isHidden = !appearancePickUpView.isHidden
    }
    @IBOutlet weak var appearancePickUpView: UIPickerView!
    
    //MARK: Variables
    let appearance = ["Light", "Dark"]
    
//MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        appearancePickUpView.delegate = self
        appearancePickUpView.dataSource = self
        appearancePickUpView.isHidden = true
    }
    
//MARK: Functions
    func setAppearance() -> [String] {
        switch traitCollection.userInterfaceStyle {
        case .light:
            overrideUserInterfaceStyle = .light
            appearanceButtonImage.setImage(UIImage(systemName: "sun.max"), for: .normal)
            appearanceButtonImage.tintColor = .black
            return appearance
        case .dark:
            overrideUserInterfaceStyle = .dark
            appearanceButtonImage.setImage(UIImage(systemName: "moon.fill"), for: .normal)
            appearanceButtonImage.tintColor = .white
            return appearance
        default:
            return ["Error"]
        }
    }
}

//MARK: Extension
extension SettingsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
        // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appearance.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        setAppearance()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (setAppearance()[row] == "Light") {
            overrideUserInterfaceStyle = .light
            appearancePickUpView.isHidden = true
        } else {
            overrideUserInterfaceStyle = .dark
            appearancePickUpView.isHidden = true
        }
    }
}
