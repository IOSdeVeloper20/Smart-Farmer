//
//  SensorsVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 17/04/2023.
//

import UIKit

class SensorsVC: UIViewController {
    
//MARK: IBOutlets
    @IBOutlet weak var TableView: UITableView!
    
//MARK: Variables
    var sensorsData: [Sensors] = [
        .init(image: UIImage(systemName: "sensor"), title: "test0", description: "testdesc0"),
        .init(image: UIImage(systemName: "sensor"), title: "test1", description: "testdesc1"),
        .init(image: UIImage(systemName: "sensor"), title: "test2", description: "testdes2")
        
    ]
//MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationController()
    }
    
//MARK: Functions
    func tableViewConfig() {
        TableView.delegate = self
        TableView.dataSource = self
        TableView.register(UINib(nibName: C.sensorCell, bundle: nil), forCellReuseIdentifier: C.sensorCell)
    }
    
    func configureNavigationController() {
        view.backgroundColor = .systemBackground
        title = "Sensors"
        navigationController?.navigationBar.prefersLargeTitles  =   true
    }
}

//MARK: Extension
extension SensorsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensorsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: C.sensorCell, for: indexPath) as! SensorsTableViewCell
        cell.setCell(usedSensors: sensorsData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let transferSensorsData = sensorsData[indexPath.row]
        //let controller = (storyboard?.instantiateViewController(identifier: C.signUpNC))!

        let sensorVC = SensorDetailsVC()
        sensorVC.sensDetails = sensorsData[indexPath.row]
        let vc = (storyboard?.instantiateViewController(withIdentifier: C.sensorDetails))!
        navigationController?.pushViewController(vc, animated: true)
    }
}
