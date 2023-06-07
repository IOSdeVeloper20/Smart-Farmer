//
//  HomeVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 15/04/2023.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

//MARK: IBOutlets
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var waterPercentageLbl: UILabel!
    
    @IBOutlet weak var waterLvlSlider: UISlider!
    
    @IBOutlet weak var tempraturePercentageLbl: UILabel!
    
    @IBOutlet weak var tempratureLvlSlider: UISlider!
    
    @IBOutlet weak var lightImage: UIImageView!
    
//MARK: Variables
    var ref: DatabaseReference?
    var degrees = [String]()
    var resetTempSlider = Float()
    var resetWaterSlider = Float()

    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make a refrence of the db
        ref = Database.database().reference()
        
        titleLbl.text = "Crop Live Statics"

        //read data from db
        obsereveWaterData()
        obsereveTempData()
        obsereveLightData()
    }
    

//MARK: Functions
    func obsereveWaterData() {
        self.ref?.child("RandomVal").observe(.value, with: { snapshot in
            self.waterPercentageLbl.text = ""
            
            if let SnapShot = snapshot.children.allObjects as? [DataSnapshot]{
                for oSnap in SnapShot {
                    if let snapVal = oSnap.value as? String {
                        self.resetWaterSlider = Float(snapVal)!
                        self.waterPercentageLbl.text = self.waterPercentageLbl.text! + snapVal + "%"
                        self.waterLvlSlider.setValue(Float(snapVal)!, animated: true)
                    }
                }
            }
        })
    }
    
    
    func obsereveTempData() {
        self.ref?.child("Temp").observe(.value, with: { snapshot in
            self.tempraturePercentageLbl.text = ""
            self.tempratureLvlSlider.setValue(self.resetTempSlider, animated: true)
            
            if let temperature = snapshot.children.allObjects as? [DataSnapshot]{
                for degree in temperature {
                    if let degreeValue = degree.value as? String {
                        self.resetTempSlider = Float(degreeValue)!
                        self.tempraturePercentageLbl.text = self.tempraturePercentageLbl.text! + degreeValue + "%"
                        self.tempratureLvlSlider.setValue(Float(degreeValue)!, animated: true)
                    }
                }
            }
        })
    }
    
    func obsereveLightData() {
        self.ref?.child("Light").observe(.value, with: { snapshot in
            self.lightImage.image = UIImage(systemName: "light.min")
            
            if let movement = snapshot.children.allObjects as? [DataSnapshot]{
                for motion in movement {
                    if let motionValue = motion.value as? String {
                        if motionValue == "On" {
                            self.lightImage.image = UIImage(systemName: "light.max")
                            self.lightImage.tintColor = .systemOrange
                        } else {
                            self.lightImage.image = UIImage(systemName: "light.min")
                            self.lightImage.tintColor = .black
                        }
                    }
                }
            }
        })
    }
}
