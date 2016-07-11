//
//  WaterFlowViewController.swift
//  CollectionDemo
//
//  Created by 王荣荣 on 7/7/16.
//  Copyright © 2016 王荣荣. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cellIdentifier"

class WaterFlowViewController: UICollectionViewController {
    var imagesArray = [UIImage]()
    var mylayout: MyLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0...17 {
            let imageName = "\(index).png"
            let image = UIImage(named: imageName)
            self.imagesArray.append(image!)
        }

        if let layout = collectionView?.collectionViewLayout as? MyLayout {
            self.mylayout = layout
            mylayout.numberOfColumns = 2
            layout.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imagesArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let image = self.imagesArray[indexPath.item]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCell
        cell.imageView.image = image
        
        return cell
    }
}

extension WaterFlowViewController: MyLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let image = self.imagesArray[indexPath.item]
        let currentCellWidth: CGFloat = (self.view.frame.size.width - 3 * mylayout.cellPadding) / CGFloat(mylayout.numberOfColumns)
        let scale = image.size.width / currentCellWidth
        let height = image.size.height / scale
        return height
    }
}
