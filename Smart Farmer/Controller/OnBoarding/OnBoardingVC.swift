//
//  OnBoardingVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 06/04/2023.
//

import UIKit

class OnBoardingVC: UIViewController {
    
//MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBAction func nextClicked(_ sender: Any) {
        if (currentPage == slides.count - 1){
            let controller = (storyboard?.instantiateViewController(identifier: Constants.signUpNC))!
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
//MARK: Variables
    var slides: [Slides] = []
    var currentPage = 0 {
        didSet {    // to get if current page ever changed
            pageControl.currentPage = currentPage
            if (currentPage == slides.count - 1) {
                nextButton.setTitle("Sign Up", for: .normal)
            } else {
                nextButton.setTitle("next", for: .normal)
            }
        }
    }
    
//MARK:Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        slides = [
            Slides( title: "This app will help you manage you crop.", description: "hello", image: UIImage(named: "Slide1")!),
            Slides( title: "This app will help you manage you crop.", description: "hello", image: UIImage(named: "Slide2")!),
            Slides( title: "This app will help you manage you crop.", description: "hello", image: UIImage(named: "Slide3")!)
        ]
    }
    

}

//MARK:Extension
extension OnBoardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //how many cells in my collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    //specify the cell to be used for each row
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.onBoardingCellID, for: indexPath) as! OnBoardingCollectionViewCell
        cell.setUp(slide: slides[indexPath.row])
        return cell
    }
    
    //The size of each image im collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
