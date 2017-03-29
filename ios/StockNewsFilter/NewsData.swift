//
//  NewsData.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 3/10/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit

class NewsData: NSObject {
    
    var time: String?
    var headline: String?
    var ticker: String?
    var volume: String?
    var articleLink: String?
    
    /*
     Constructor for our NewsData Class
     */
    init(time: String, headline: String, ticker: String, volume: String, articleLink: String) {
        self.time = time
        self.headline = headline
        self.ticker = ticker
        self.volume = volume
        self.articleLink = articleLink
    }
}
