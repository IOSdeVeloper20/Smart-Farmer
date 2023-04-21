//
//  OnBoardingCollectionViewCell.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 06/04/2023.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {

//MARK: IBOutlets
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
//MARK:Functions
    func setUp(slide: Slides) {
        slideImage.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
    
}
