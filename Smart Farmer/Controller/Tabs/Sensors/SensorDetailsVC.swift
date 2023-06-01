//
//  SensorDetailsVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 18/04/2023.
//

import UIKit

class SensorDetailsVC: UIViewController {

//MARK: IBOTlets
    @IBOutlet weak var sensorDetailsImage: UIImageView!
    @IBOutlet weak var sensorDetailsTitleLbl: UILabel!
    @IBOutlet weak var sensorDetailsDescriptionLbl: UILabel!
    
//MARK: Variables
    var sensDetails: Sensors!
    
//MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetails()
    }

//MARK: Functions
    func setUpDetails() {
        sensorDetailsImage.image = sensDetails?.image
        sensorDetailsTitleLbl.text = sensDetails?.title
        sensorDetailsDescriptionLbl.text = sensDetails?.description
        print("hello sensirs")
    }
}
