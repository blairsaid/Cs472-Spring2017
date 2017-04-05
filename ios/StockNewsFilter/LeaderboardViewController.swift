//
//  HomeViewController.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 2/10/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let menuManager = MenuManager()
    
    var financeData: [LeaderboardData] = []
    
    /*
        This function will be used to fetch our data from the json
    */
    func fetchData() {
        let url = URL(string: "http://ec2-54-201-191-25.us-west-2.compute.amazonaws.com/cgi-bin/leaderboard.py")
        let task = URLSession.shared.dataTask(with: url!) {(data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error")
            } else {
                self.financeData = [LeaderboardData]()
                if let content = data {
                    do {
                        //Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: String]]
                        /*
                        //debugging information
                        print(myJson!)
                        print(myJson!.count)
                        */
                        
                        //place section titles
                        let titleData = LeaderboardData()
                        titleData.ticker = "Ticker"
                        titleData.percentChange = "Percent Change"
                        titleData.price = "Price"
                        titleData.weightedavebasicsharesos = "OS Shares"
                        titleData.volume = "Volume"
                        self.financeData.append(titleData)
                        
                        for items in myJson! {
                            let finance = LeaderboardData()
                            if let ticker = items["ticker"], let osShares = items["os_shares"], let volumes = items["volume"], let price = items["price"], let pctChange = items["pct_change"] {
                                
                                finance.ticker = ticker
                                finance.percentChange = pctChange
                                finance.price = price
                                finance.weightedavebasicsharesos = osShares
                                finance.volume = volumes
                                
                                /*
                                //debugging information
                                print("ticker: \(finance.ticker)")
                                print("os_shares: \(finance.weightedavebasicsharesos)")
                                print("volume: \(finance.volume)")
                                print("price: \(finance.price)")
                                print("pct_change: \(finance.percentChange)")
                                */
                            }
                            self.financeData.append(finance)
                        }
                        DispatchQueue.main.sync {
                            self.myCollectionView.reloadData()
                        }
                    } catch {
                        print("error")
                    }
                }
            }
        }
        task.resume()
    }
    
    /*
     This function determines the amount of columns.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.financeData.count
        //return 5
    }
    
    /*
     This function determines the amount of rows.
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        //return self.financeData.count
        return 5
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
        
        if indexPath.row == 0 {
            //set the background and text color for the labels
            cell.backgroundColor = UIColor.darkGray
            cell.myLabel?.textColor = UIColor.white
        } else {
            //set the background and text color for the other cells
            cell.backgroundColor = UIColor.white
            cell.myLabel?.textColor = UIColor.black
        }
        
        //set the label for each cell
        if indexPath.section == 0 {
            cell.myLabel.text = financeData[indexPath.row]?.ticker
        } else if indexPath.section == 1 {
            cell.myLabel.text = financeData[indexPath.row]?.volume
        } else if indexPath.section == 2 {
            cell.myLabel.text = financeData[indexPath.row]?.price
        } else if indexPath.section == 3 {
            cell.myLabel.text = financeData[indexPath.row]?.percentChange
        } else {
            cell.myLabel.text = financeData[indexPath.row]?.weightedavebasicsharesos
        }
        
        return cell
    }
    
    @IBAction func MenuPressed(_ sender: Any) {
        menuManager.openMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchData() //load the JSON data into the collection view
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
