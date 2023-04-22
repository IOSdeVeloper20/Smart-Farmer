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
    }
    
    @IBAction func AppearanceButton(_ sender: UIButton) {
        if appearancePickUpView.isHidden {
            appearancePickUpView.isHidden = false
        }
    }
    
    @IBOutlet weak var appearancePickUpView: UIPickerView!
    @IBOutlet weak var settingsImage: UIImageView!
    
    //MARK: Variables
    let appearance = ["Dark", "Light"]
    
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
            settingsImage.image = UIImage(systemName: "sun.max")
            let lightAppearance = ["Light", "Dark"]
            return lightAppearance
        case .dark:
            overrideUserInterfaceStyle = .dark
            settingsImage.image = UIImage(systemName: "moon.fill")
            let darkAppearance = ["Dark", "Light"]
            return darkAppearance
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
        return setAppearance().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        setAppearance()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        switch row {
//        case 0:
//            overrideUserInterfaceStyle = .dark
//        case 1:
//            overrideUserInterfaceStyle = .light
//        default:
//            return
//        }
        if (setAppearance()[row] == "Light") {
            overrideUserInterfaceStyle = .light
            appearancePickUpView.isHidden = true
        } else {
            overrideUserInterfaceStyle = .dark
            appearancePickUpView.isHidden = true
        }
    }
}
//how to make uipickerview to be set on the first element every time it opens
