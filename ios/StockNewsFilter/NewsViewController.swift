//
//  ViewController.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 2/9/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    let menuManager = MenuManager()
    
    
    var newsData = [NewsData]()
    
    var time = ["Time",
                "17:06:49",
                "17:05:34",
                "17:05:03",
                "17:04:59",
                "17:03:17",
                "17:02:11",
                "17:01:10",
                "16:47:29",
                "16:46:13",
                "16:43:20",
                "16:43:02",
                "16:43:01",
                "16:42:51",
                "16:30:15",
                "16:30:15"]
    var articleURL = ["",
                      "http://www.investopedia.com/news/ubs-ceo-gets-bonus-reduced-bac-ms/?partner=YahooSA",
                      "https://www.forbes.com/sites/bryanrich/2017/03/10/what-bernanke-thinks-about-the-outlook/?utm_source=yahoo&utm_medium=partner&utm_campaign=yahootix&partner=yahootix#529a3c163dae",
                      "https://www.thestreet.com/story/14036171/1/ciena-when-will-investors-see-the-light.html?puc=yahoo&cm_ven=YAHOO",
                      "http://www.investopedia.com/news/nvidia-ups-its-cloud-artifical-intelligence-game/?partner=YahooSA",
                      "http://www.insidermonkey.com/blog/is-advanced-micro-devices-amd-a-good-investment-565350/",
                      "http://finance.yahoo.com/news/strike-hits-output-top-peru-222105450.html",
                      "http://www.barrons.com/articles/arista-up-83-is-still-a-good-bet-1489210619?mod=yahoobarrons&ru=yahoo",
                      "http://alphatrends.tumblr.com/post/158243565270/stock-market-video-analysis",
                      "http://realmoney.thestreet.com/articles/03/10/2017/its-called-watch-list-reason?puc=yahoo&cm_ven=YAHOO",
                      "https://www.bloomberg.com/news/articles/2017-03-10/nissan-ford-bmw-sue-takata-over-faulty-airbag-losses?cmpid=yhoo.headline",
                      "http://finance.yahoo.com/news/goodyear-shares-concepts-technology-urban-143900489.html",
                      "http://finance.yahoo.com/news/vetr-downgrades-regeneron-off-share-173534525.html",
                      "http://www.capitalcube.com/blog/index.php/nucor-corp-breached-its-50-day-moving-average-in-a-bullish-manner-nue-us-march-9-2017/",
                      "http://finance.yahoo.com/news/top-5-themes-deutsche-banks-182247677.html",
                      "http://blogs.barrons.com/techtraderdaily/2017/03/10/recent-western-digital-weakness-a-buying-opportunity-benchmark/?mod=yahoobarrons&ru=yahoo"]
    var headlines = ["Headlines",
                     "UBS CEO Sergio ermotti's Bonus Gets Reduced",
                     "What Bernanke Thinks About The Outlook",
                     "Ciene: When Will Investors See the Light?",
                     "NVDIA Ups Its Cloud Artificial Intelligence Game",
                     "Is Advanced Micro Devices (AMD) a Good Investment?",
                     "Strike hits output at top Peru copper min Cerro Verde -union",
                     "[$$] Arista, Up 83%, Is Still a Good Bet",
                     "Stock Market Video Analysis",
                     "It's Called a Watch List for a Reason",
                     "Nissan, Ford, BMW Sue Takata Over Faulty Airbag Losses",
                     "Goodyear Shares Concepts, Technology for Urban Mobility at Geneva International Motor Show",
                     "Vetr Downgrades Regeneron Off Of Share Rise",
                     "Nucor Corp. breached its 50 day moving average in a Bullish  Manner : NUE-US : March 9, 2017",
                     "Top 5 Themes From Deutsche Bank's Media, Telecom Conference",
                     "Recent Western Digital Weakness A Buying Opportunity: Benchmark"]
    var ticker = ["Ticker",
                  "BAC",
                  "GE",
                  "T",
                  "NVDA",
                  "INTC",
                  "FCX",
                  "CSCO",
                  "ATVI",
                  "CHK",
                  "F",
                  "GT",
                  "REGN",
                  "NUE",
                  "CCI",
                  "STX"]
    var volume = ["Volume",
                  "18832081",
                  "135418",
                  "46584367",
                  "2493055",
                  "168718",
                  "224224",
                  "20141259",
                  "1118026",
                  "423154",
                  "1417693",
                  "445795",
                  "150046316",
                  "425217",
                  "1417693",
                  "20141259"]
    
    //create arbitrary items for data set
    func createitems() -> [NewsData] {
        var items = [NewsData]()
        
        var count: Int = 0
        for _ in ticker {
            items.append(NewsData(time: time[count], headline: headlines[count], ticker: ticker[count], volume: volume[count], articleLink: articleURL[count]))
            count = count + 1
        }
        
        return items
    }
    
    /*
        This function determines the amount of columns.
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    /*
        This function determines the amount of rows.
    */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.newsData.count
        //return 16
    }
    
    /*
        This function determines the objects in the cell
    */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
        cell.myLabel?.text = nil
        
        cell.myLabel?.textAlignment = NSTextAlignment.left
        
        //set the border for each cell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        
        if indexPath.section == 0 {
            //set the background and text color for the labels
            cell.backgroundColor = UIColor.darkGray
            cell.myLabel?.textColor = UIColor.white
        } else {
            //set the background and text color for the other cells
            cell.backgroundColor = UIColor.white
            cell.myLabel?.textColor = UIColor.black
        }
        
        //set the label for each cell
        if indexPath.row == 0 {
            cell.myLabel.text = newsData[indexPath.section].time
        } else if indexPath.row == 1 {
            cell.myLabel.text = newsData[indexPath.section].headline
        } else if indexPath.row == 2 {
            cell.myLabel.text = newsData[indexPath.section].ticker
        } else {
            cell.myLabel.text = newsData[indexPath.section].volume
        }
        
        return cell
    }
    
    /*
        This function allows the user to see the article in Safari when Headline is pressed
    */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 && indexPath.row == 1 {
            let url = URL(string: newsData[indexPath.section].articleLink!)
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func MenuPressed(_ sender: Any) {
        menuManager.openMenu()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newsData = createitems()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

