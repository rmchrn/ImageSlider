//
//  ViewController.swift
//  ImageSlider
//
//  Created by Ramcharan Reddy Gaddam on 09/06/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageSlider: ImageSliderCollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSlider.updatePageIndex = { [weak self ] page in
            self?.pageControl.currentPage = page
        }
        let images: [UIImage]? = [UIImage(named: "\(1)")!, UIImage(named: "\(2)")!, UIImage(named: "\(3)")!, UIImage(named: "\(4)")!, UIImage(named: "\(5)")!]
        pageControl.numberOfPages = images!.count
        imageSlider.images = images
    }


}

