//
//  CustomTableViewCell.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 01/06/2023.
//

import UIKit

// to make shadow for collectionView cells
class CustomTableViewCell: UIView {
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        initialSetUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetUp()
    }
    
    private func initialSetUp() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
    }
}
