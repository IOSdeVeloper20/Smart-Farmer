//
//  HomeVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 15/04/2023.
//

import UIKit

class HomeVC: UIViewController {

    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = view.center

        //draw trach
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(trackLayer)
        
        //draw a circle
//        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProgressTap)))
    }
    
    @objc private func handleProgressTap() {
        print("heloo")
        let basicanimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicanimation.toValue = 1
        basicanimation.duration = 2
        //to keep the animation after it ends
        basicanimation.fillMode = CAMediaTimingFillMode.forwards
        basicanimation.isRemovedOnCompletion = false
        shapeLayer.add(basicanimation, forKey: "basic")
    }
}
