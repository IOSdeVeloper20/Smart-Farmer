//
//  ControlVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 18/04/2023.
//

import UIKit
import Firebase

class ControlVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var ControlTableVIew: UITableView!
    
    //MARK: Variables
    //make a refrence of the db
    var ref = Database.database().reference()
    
    var controls: [Controls] = [
        .init(image: UIImage(systemName: "fanblades"), title: "fans"),
        .init(image: UIImage(systemName: "drop"), title: "Water Pump"),
        .init(image: UIImage(systemName: "lightbulb"), title: "Lights")
    ]
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
    }
    
    //MARK: Functions
    func tableViewConfig() {
        ControlTableVIew.delegate = self
        ControlTableVIew.dataSource = self
        
        /*UINib: the name of nib cell file
         forCellReuseIdentifier: the id that is set for the cell*/
        ControlTableVIew.register(UINib(/*nibName must be the real name of Xib file*/nibName: Constants.controlCell, bundle: nil), forCellReuseIdentifier: Constants.controlCell)
    }
}

//MARK: Extension

extension ControlVC: UITableViewDataSource, UITableViewDelegate {
    
    // number of cells to be returned
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controls.count
    }
    
    //what each cell will display
    /*withIdentifier: the id that is set for the cell
     as >> the name of the controller class*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ControlTableVIew.dequeueReusableCell(withIdentifier: Constants.controlCell, for: indexPath) as! ControlTableViewCell
        cell.setUpControl(controlData: controls[indexPath.row])
        
        switch indexPath.row {
        case 0:
            // Handle functionality for the first cell's switch button
            cell.switchButtonHandler = { isOn in
                // Handle functionality for the first cell's switch button
                if isOn {           //fan switch is on
                    //write to fan node in db
                    self.ref.child("controlTempLight/tempLight").setValue("turnOnTempLED")
                    print("fan switch turned on")
                } else {            //fan switch is off
                    //write to fan node in db
                    self.ref.child("controlTempLight/tempLight").setValue("turnOffTempLED")
                    print("fan switch turned off")
                }
            }
            break
        case 1:
            // Handle functionality for the water pump cell switch button
            cell.switchButtonHandler = { isOn in
                // Handle functionality for the first cell's switch button
                if isOn {             //water pump switch is on
                    //write to water pump node in db
                    self.ref.child("waterPumpControl").setValue("On")
                    print("water pump switch turned on")
                } else {              //water pump switch is off
                    //write to water pump node in db
                    self.ref.child("waterPumpControl").setValue("Off")
                    print("water pump switch turned off")
                }
            }
            break
        case 2:
            // Handle functionality for the light cell switch button
            cell.switchButtonHandler = { isOn in
                // Handle functionality for the first cell's switch button
                if isOn {           //light switch is on
                    //write to light node in db
                    self.ref.child("controlLight/light").setValue("turnOnMovementLED")
                    print("light switch turned on")
                } else {            //light switch is off
                    //write to light node in db
                    self.ref.child("controlLight/light").setValue("turnOffMovementLED")
                    print("light switch turned off")
                }
            }
            break
        default:
            break
        }
        
        return cell
    }
}
