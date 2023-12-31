//
//  ControlTableViewCell.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 01/06/2023.
//

import UIKit

class ControlTableViewCell: UITableViewCell {

//MARK: IBOutlets
    @IBOutlet weak var controlImage: UIImageView!
    @IBOutlet weak var controlLabel: UILabel!
    
    @IBAction func controlSwitch(_ sender: UISwitch) {
        switchButtonHandler?(sender.isOn)
    }
//MARK: Variables
    var switchButtonHandler: ((Bool) -> Void)?
//    switchValueChangedHandler?(sender.isOn)
    
//MARK: Fucntions
    func setUpControl(controlData: Controls) {
        controlImage.image = controlData.image
        controlLabel.text = controlData.title
    }
}
