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
        .init(image: UIImage(named: "Temperature sensor"), title: "Temperature Sensor", description: "testdesc0"),
        .init(image: UIImage(named: "Temperature sensor"), title: "test1", description: "testdesc1"),
        .init(image: UIImage(named: "Temperature sensor"), title: "test2", description: "testdes2")
        
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
