//
//  GraphVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 31/05/2023.
//

import Charts
import UIKit
import Firebase

class GraphVC: UIViewController, ChartViewDelegate {
    
//MARK: Variables
    let lineChart = LineChartView()
    var ref: DatabaseReference?
    var tempEntry = [ChartDataEntry]()
    var waterEntry = [ChartDataEntry]()
    var tempxAxisPosition: Double = 0
    var waterxAxisPosition: Double = 0
    
    
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        
        //make a refrence of the db
        ref = Database.database().reference()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 0, y: 0,width: self.view.frame.size.width,height: self.view.frame.size.height)
        
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        observeTracks()
    }
    
//MARK: Functions
    func observeTracks() {
        
        //chart line 1 data
        self.ref?.child("Temp").observe(.value, with: { snapshot in
            
            if let temperatureInChart = snapshot.children.allObjects as? [DataSnapshot] {
                for degree in temperatureInChart {
                    if let degreeValue = degree.value as? String {
                        self.tempEntry.append(ChartDataEntry(x: self.tempxAxisPosition, y: Double(degreeValue)!))
                        self.tempxAxisPosition += 1
                    }
                }
                
                // Sort the entries based on x-values
                self.tempEntry.sort { $0.x < $1.x }
                
                let tempSet = LineChartDataSet(entries: self.tempEntry)
                tempSet.setColor(.systemRed)
                tempSet.drawCirclesEnabled = false
                tempSet.label = "Temperature" // Set the label for the second line
                
                // Retrieve the data for the second line from the database
                self.ref?.child("RandomVal").observe(.value, with: { snapshot in
                    if let waterData = snapshot.children.allObjects as? [DataSnapshot] {
                        for water in waterData {
                            if let drop = water.value as? String {
                                self.waterEntry.append(ChartDataEntry(x: self.waterxAxisPosition, y: Double(drop)!))
                                self.waterxAxisPosition += 1
                            }
                        }
                        
                        // Sort the entries based on x-values
                        self.waterEntry.sort { $0.x < $1.x }
                        
                        let waterSet = LineChartDataSet(entries: self.waterEntry)
                        waterSet.setColor(.systemBlue)
                        waterSet.drawCirclesEnabled = false
                        waterSet.label = "Water" // Set the label for the second line
                        
                        // Create a LineChartData object and add both data sets
                        let data = LineChartData(dataSets: [tempSet, waterSet])
                        self.lineChart.data = data
                    }
                })
            }
        })
    }
}
