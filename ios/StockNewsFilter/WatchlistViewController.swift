//
//  MenuItemViewController.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 3/23/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit

class WatchlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var watchlistTableView: UITableView!
    
    @IBOutlet weak var userlistTableView: UITableView!
    
    let menuManager = MenuManager()
    
    var financeData: [LeaderboardData] = []
    
    var userData: [LeaderboardData?] = []
    
    /*
     This function will be used to fetch our data from the json
     */
    func fetchData() {
        let url = URL(string: "http://ec2-54-201-191-25.us-west-2.compute.amazonaws.com/cgi-bin/leaderboard.py")
        let task = URLSession.shared.dataTask(with: url!) {(data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error")
                return
            } else {
                self.financeData = [LeaderboardData]()
                if let content = data {
                    do {
                        //Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: String]]
                        
                        for items in myJson! {
                            let finance = LeaderboardData()
                            if let ticker = items["ticker"], let osShares = items["os_shares"], let volumes = items["volume"], let price = items["price"], let pctChange = items["pct_change"] {
                                
                                finance.ticker = ticker
                                finance.percentChange = pctChange
                                finance.price = price
                                finance.weightedavebasicsharesos = osShares
                                finance.volume = volumes
                                
                            }
                            self.financeData.append(finance)
                        }
                        DispatchQueue.main.sync {
                            self.watchlistTableView.reloadData()
                        }
                    } catch {
                        print("error")
                    }
                }
            }
        }
        task.resume()
    }
    
    @IBAction func MenuPressed(_ sender: Any) {
        menuManager.openMenu()
    }
    
    /*
        This function determines the amount of sections in each table view
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
        This function determines the amount of rows for each table view
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        
        if tableView == watchlistTableView {
            count = self.financeData.count
        }
        
        if tableView == userlistTableView {
            count = self.userData.count
        }
        return count!
    }
    
    /*
        This function determines the objects in each cell
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = watchlistTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let color = UIColor(red: 95/255, green: 207/255, blue: 153/255, alpha: 0.5)
        cell.tintColor = color
        
        if tableView == watchlistTableView {
            cell.textLabel?.text = financeData[indexPath.row].ticker
            cell.detailTextLabel?.text = financeData[indexPath.row].price
            cell.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
        }
        
        if tableView == userlistTableView {
            cell.textLabel?.text = userData[indexPath.row]?.ticker
            cell.detailTextLabel?.text = userData[indexPath.row]?.price
            cell.backgroundColor = UIColor.white
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
            
            //cell.textLabel?.text = userTickers[indexPath.row]
            //cell.detailTextLabel?.text = userPrice[indexPath.row]
        }
        
        
        
        return cell
    }
    
    /*
        This function allows the 'Rising Stocks' to be uneditable and the 'My Watch List' to be editable
    */
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        var decision: Bool?
        if tableView == watchlistTableView {
            decision = false
        }
        if tableView == userlistTableView {
            decision = true
        }
        return decision!
    }
    
    /*
        This function allows the user to remove stocks from their watch list
    */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == userlistTableView {
            if editingStyle == UITableViewCellEditingStyle.delete {
                userData.remove(at: indexPath.row)
                userlistTableView.reloadData()
            }
        }
    }
    
    /*
        This function allows the user the user add a stock to their watch list
    */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == watchlistTableView {
            let newData = LeaderboardData()
            newData.ticker = financeData[indexPath.row].ticker
            newData.price = financeData[indexPath.row].price
            newData.percentChange = financeData[indexPath.row].percentChange
            newData.weightedavebasicsharesos = financeData[indexPath.row].weightedavebasicsharesos
            newData.volume = financeData[indexPath.row].volume
            self.userData.append(newData)
        }
        userlistTableView.reloadData()
    }
    
    /*
        This function sets the title for each table
    */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        if tableView == watchlistTableView {
            title = "Rising Stocks"
        }
        if tableView == userlistTableView{
            title = "My Watch List"
        }
        return title!
    }
    
    /*
        This function sets the height for each table's title
    */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    /*
        This function allows user to view details of each stock on the watch list
    */
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        var ticker: String?
        var price: String?
        var volume: String?
        var percent_change: String?
        var osShares: String?
        
        if tableView == watchlistTableView {
            ticker = financeData[indexPath.row].ticker
            price = financeData[indexPath.row].price
            volume = financeData[indexPath.row].volume
            percent_change = financeData[indexPath.row].percentChange
            osShares = financeData[indexPath.row].weightedavebasicsharesos
        }
        if tableView == userlistTableView {
            ticker = userData[indexPath.row]?.ticker
            price = userData[indexPath.row]?.price
            volume = userData[indexPath.row]?.volume
            percent_change = userData[indexPath.row]?.percentChange
            osShares = userData[indexPath.row]?.weightedavebasicsharesos
        }
        
        let alertController = UIAlertController(title: ticker!, message: "Price: \(price!) \n  Volume:  \(volume!) \n Percent Change: \(percent_change!) \n Outstanding Shares: \(osShares!)", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        watchlistTableView.delegate = self
        watchlistTableView.dataSource = self
        userlistTableView.delegate = self
        userlistTableView.dataSource = self
        userlistTableView.reloadData()
        navigationController?.navigationBar.barTintColor = UIColor(red: 95/255, green: 207/255, blue: 153/255, alpha: 0.5)
        
        //preload the data into the Rising Stocks table
        fetchData()
        
        //reset application badge number to 0 when user views watchlist
        UIApplication.shared.applicationIconBadgeNumber = 0
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
