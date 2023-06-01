//
//  ControlVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 18/04/2023.
//

import UIKit

class ControlVC: UIViewController {

//MARK: IBOutlets
    @IBOutlet weak var ControlTableVIew: UITableView!

//MARK: Variables
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
        return cell
    }

    //when any cell is selected
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
    
}
