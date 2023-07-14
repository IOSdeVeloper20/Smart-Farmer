//
//  SensorsVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 17/04/2023.
//

import UIKit

class SensorsVC: UIViewController {
    
//MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
//MARK: Variables
    var sensorsData: [Sensors] = [
        .init(image: UIImage(named: "PIR sensor"), title: "PIR movement detection Sensor", description: "Also known as a data selector, is a device that selects between several analog or digital input signals and forwards the selected input to a single output line. The selection is directed by a separate set of digital inputs known as select lines."),
        .init(image: UIImage(named: "soil sensor"), title: "Soil Moisture Sensor", description: "A soil moisture sensor can read the amount of moisture present in the soil surrounding it. This sensor uses the two probes to pass current through the soil, and then it reads that resistance to get the moisture level. More water makes the soil conduct electricity more easily, while dry soil conducts electricity poorly."),
        .init(image: UIImage(named: "Temperature sensor"), title: "DHT11 Temperature Sensor", description: "Is a device or device that can convert temperature and humidity into electrical signals that can be easily measured and processed.")
        
    ]
//MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //configureNavigationController()
    }
    
//MARK: Functions
    func tableViewConfig() {
        tableView.delegate = self
        tableView.dataSource = self
        
        /*UINib: the name of nib cell file
         forCellReuseIdentifier: the id that is set for the cell*/
        tableView.register(UINib(/*nibName must be the real name of Xib file*/nibName: Constants.sensorCell, bundle: nil), forCellReuseIdentifier: Constants.sensorCell)
    }
}

//MARK: Extension
extension SensorsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensorsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.sensorCell, for: indexPath) as! SensorsTableViewCell
        cell.setCell(usedSensors: sensorsData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sensorVC = SensorDetailsVC.instatiate()
        sensorVC.sensDetails = sensorsData[indexPath.row]
        navigationController?.pushViewController(sensorVC, animated: true)
    }
}
