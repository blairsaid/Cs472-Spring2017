//
//  CustomCollectionViewLayout.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 2/10/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout {
    
    //define the width and height for each cell
    let cellWidth: CGFloat = 50
    let cellHeight: CGFloat = 160
    
    var dataSourceDidUpdate = true
    
    //create a dictionary to hold UICollectionViewLayoutAttributes for each cell (like a Hash Table)
    //the layout attributes will define the cell's size and position (x,y, and z index)
    var cellAttributesDictionary = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    
    //Initialize the size of the area of the collection view to empty
    var contentSize = CGSize.zero
    
    /*
        This function will get the contentSize (amount of cells) of the collection view for initial load.
    */
    override var collectionViewContentSize: CGSize {
        get {
            return contentSize
        }
    }
    
    /*
        This function will load the initial view of the customized collection view.
        It will save the attributes for each cell and the area of the collection view.
    */
    override func prepare() {
        
        //have the cells stay in place within the container when the user scrolls
        collectionView?.bounces = false
        
        //build the UICollectionViewLayoutAttributes for each cell
        for section in 0 ..< collectionView!.numberOfSections {
            for item in 0 ..< collectionView!.numberOfItems(inSection: section) {
                let cellIndex = IndexPath(item: item, section: section)
                let xPos = CGFloat(item) * cellWidth
                let yPos = CGFloat(section) * cellHeight
                
                //CGRect will define the origin and size of the cell frame
                let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                
                //Inverse the cell direction
                cellAttributes.frame = CGRect(x: yPos, y: xPos, width: cellHeight, height: cellWidth)
                
                //save the attributes
                cellAttributesDictionary[cellIndex] = cellAttributes
            }
        }
        
        //Set the contentSize of the collection view
        let contentWidth = CGFloat(collectionView!.numberOfItems(inSection: 0)) * cellWidth
        let contentHeight = CGFloat(collectionView!.numberOfSections) * cellHeight
        contentSize = CGSize(width: contentHeight, height: contentWidth)
    }
    
    /*
        This function sets the cell attributes for each cell
    */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        for cellAttributes in cellAttributesDictionary.values {
            if rect.intersects(cellAttributes.frame) {
                attributesInRect.append(cellAttributes)
            }
        }
        
        return attributesInRect
    }
    
    /*
        This function sets the layout attributes for each cell in the collection view
    */
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributesDictionary[indexPath]
    }
}
