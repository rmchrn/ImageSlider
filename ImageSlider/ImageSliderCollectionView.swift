//
//  ImageSliderCollectionView.swift
//  ImageSlider
//
//  Created by Ramcharan Reddy Gaddam on 09/06/20.
//  Copyright © 2020 Ramcharan. All rights reserved.
//

import UIKit

struct ImageSliderConstants {
    static let minimumLineSpacing: CGFloat = 0
    static let minimumInterItemSpacing: CGFloat = 0
}

class ImageSliderCollectionView: UICollectionView {
    private var timer: Timer?
    private var currentIndex = 0
    var updatePageIndex: ((Int)->Void)?
    var images: [UIImage]?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: scroll(_:))
    }
    
    @objc func scroll(_ aTimer: Timer) {
        let indexPathOfCurrentCell = IndexPath(item: currentIndex, section: 0)
        if indexPathOfCurrentCell.item < images!.count - 1 {
            self.scrollToItem(at: IndexPath(item: indexPathOfCurrentCell.item + 1, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
        } else {
            self.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / self.frame.size.width)
        if let updatePage = updatePageIndex {
            updatePage(currentIndex)
        }
    }
    
}

extension ImageSliderCollectionView: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "imageItem", for: indexPath) as? ImageCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "imageItem", for: indexPath)
        }
        item.backgroundView = UIImageView(image: images![indexPath.item])
        return item
    }
}

extension ImageSliderCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        ImageSliderConstants.minimumInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        ImageSliderConstants.minimumLineSpacing
    }
}
