//
//  SensorsTableViewCell.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 17/04/2023.
//

import UIKit

class SensorsTableViewCell: UITableViewCell {

//MARK: IBOutlets
    @IBOutlet weak var SensorImage: UIImageView!
    @IBOutlet weak var SensorLbl: UILabel!

//MARK: Life Cycle
    func setCell(usedSensors: Sensors) {
        SensorImage.image = usedSensors.image
        SensorLbl.text = usedSensors.title
    }

    
}
