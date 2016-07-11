//
//  MyLayout.swift
//  collectionView
//
//  Created by 王荣荣 on 7/11/16.
//  Copyright © 2016 王荣荣. All rights reserved.
//

import UIKit

protocol MyLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat
}

class MyLayout: UICollectionViewLayout {
    private var layoutAttrs = [UICollectionViewLayoutAttributes]()
    var numberOfColumns = 2
    private var columnHeights = [CGFloat]()
    private var contentHeight: CGFloat = 0
    var  cellPadding: CGFloat = 10
    var delegate: MyLayoutDelegate!
    override func prepareLayout() {
        self.columnHeights = [CGFloat](count: numberOfColumns, repeatedValue: 0)
        for item in 0..<collectionView!.numberOfItemsInSection(0) {
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let attr = self.layoutAttributesForItemAtIndexPath(indexPath)
            self.layoutAttrs.append(attr!)
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(0, self.contentHeight + cellPadding)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.layoutAttrs
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        let width = (self.collectionView?.frame.size.width)! - (collectionView?.contentInset.left)! - (collectionView?.contentInset.right)!
        let columnWidth = width / CGFloat(numberOfColumns)
        let cellHeight = self.delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath)
        var destColumn = 0
        var minColumnHeight = self.columnHeights[0]
        for index in 0..<self.columnHeights.count {
            let columnHeight = self.columnHeights[index]
            if minColumnHeight > columnHeight {
                minColumnHeight = columnHeight
                destColumn = index
            }
        }
        
        let cellWidth = columnWidth - cellPadding
        let cellX = CGFloat(destColumn) * columnWidth + cellPadding
        let cellY = minColumnHeight + cellPadding
        attr.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight)
        self.columnHeights[destColumn] = CGRectGetMaxY(attr.frame)
        let newContentHeight = self.columnHeights[destColumn]
        if self.contentHeight < newContentHeight {
            self.contentHeight = newContentHeight
        }
        return attr
    }

}
