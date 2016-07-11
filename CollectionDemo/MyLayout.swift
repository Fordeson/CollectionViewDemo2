//
//  MyLayout.swift
//  CollectionDemo
//
//  Created by 王荣荣 on 7/7/16.
//  Copyright © 2016 王荣荣. All rights reserved.
//

import UIKit

protocol MyLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath) -> CGFloat
}

class MyLayout: UICollectionViewLayout {
    private var layoutAttrs = [UICollectionViewLayoutAttributes]()
    var cellPadding: CGFloat = 6.0
    var numberOfColumns = 3
    var delegate: MyLayoutDelegate!
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    override func prepareLayout() {
        if self.layoutAttrs.isEmpty {
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
        var column = 0
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth )
        }
        
         for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let cellHeight = delegate.collectionView(collectionView!, heightForPhotoAtIndexPath: indexPath)
            let height = cellPadding + cellHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            attributes.frame = insetFrame
            self.layoutAttrs.append(attributes)
            contentHeight = max(contentHeight, CGRectGetMaxY(frame))
            yOffset[column] = yOffset[column] + height
            
            column = column >= (numberOfColumns - 1) ? 0 : ++column
            }
        }
    }
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return self.layoutAttrs
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake((self.collectionView?.frame.size.width)!, contentHeight)
    }
}
