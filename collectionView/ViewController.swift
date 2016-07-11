//
//  ViewController.swift
//  collectionView
//
//  Created by 王荣荣 on 7/11/16.
//  Copyright © 2016 王荣荣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var images = [UIImage]()
    private let cellIdentifier = "cellIdentifier"
    
    private var layout: MyLayout!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.collectionView.dataSource = self
        for index in 1...100 {
            let imageName = "images (\(index)).jpg"
            let image = UIImage(named: imageName)
            self.images.append(image!)
        }
        
        if let layout = collectionView.collectionViewLayout as? MyLayout {
            self.layout = layout
            layout.numberOfColumns = 3
             self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, layout.cellPadding)
            layout.delegate = self
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! MyCell
        cell.imageView.image = self.images[indexPath.item]
        cell.label.text = "\(indexPath.item + 1)"
        return cell
    }
}

extension ViewController: MyLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let image = self.images[indexPath.item]
        let currentWidth = (collectionView.frame.size.width - CGFloat(layout.numberOfColumns + 1) * layout.cellPadding) / CGFloat(layout.numberOfColumns)
        let scale = image.size.width / currentWidth
        let height = image.size.height / scale
        return height
    }
}

