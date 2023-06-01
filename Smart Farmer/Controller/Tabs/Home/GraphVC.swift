//
//  GraphVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 31/05/2023.
//

import Charts
import UIKit

class GraphVC: UIViewController, ChartViewDelegate {

    let lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 0, y: 0,
                                 width: self.view.frame.size.width,
                                 height: self.view.frame.size.height)
        
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        var entry = [ChartDataEntry]()
        
        for x in 0..<10 {
            entry.append(ChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = LineChartDataSet(entries: entry)
        //set.colors = ChartColorTemplates.colorful()
        set.setColor(.red)
        set.drawCirclesEnabled = false

        let data = LineChartData(dataSets: [set])
        lineChart.data = data
    }
}
