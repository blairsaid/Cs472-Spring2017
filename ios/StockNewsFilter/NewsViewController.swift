//
//  ViewController.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 2/9/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit
import UserNotifications

class NewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    let themeColor = UIColor(red: 95/255, green: 207/255, blue: 153/255, alpha: 0.5)
    let menuManager = MenuManager()
    
    var newsData: [NewsData?] = []
    
    /*
        This function will be used to fetch our data from the json
    */
    func fetchData() {
        let url = URL(string: "http://ec2-54-201-191-25.us-west-2.compute.amazonaws.com/cgi-bin/pressboard.py")
        let task = URLSession.shared.dataTask(with: url!) {(data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error")
                return
            } else {
                self.newsData = [NewsData]()
                if let content = data {
                    do {
                        //Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: String]]
                        
                        //place section titles
                        let titleData = NewsData()
                        titleData.ticker = "Ticker"
                        titleData.time = "Time"
                        titleData.openPrice = "Open Price"
                        titleData.descript = "Description"
                        titleData.headline = "Headline"
                        titleData.articleLink = "URL"
                        self.newsData.append(titleData)
                        
                        for items in myJson! {
                            let press = NewsData()
                            if let openPrices = items["open_price"], let descrip = items["description"], let ticker = items["ticker"], let title = items["title"], let time = items["time"], let url = items["url"] {
                                
                                press.ticker = ticker
                                press.time = time
                                press.openPrice = openPrices
                                press.descript = descrip
                                press.headline = title
                                press.articleLink = url
                            }
                            self.newsData.append(press)
                        }
                        DispatchQueue.main.sync {
                            self.MyCollectionView.reloadData()
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
        This function determines the amount of rows.
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.newsData.count
    }
    
    /*
        This function determines the amount of columns.
    */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 4
    }
    
    /*
        This function determines the objects in the cell
    */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
        //cell.myLabel?.text = nil
        
        cell.myLabel?.textAlignment = NSTextAlignment.left
        cell.myLabel.textColor = UIColor.white
        cell.layer.borderWidth = 1
        
        if indexPath.row == 0 {
            //set the background and text color for the labels
            cell.backgroundColor = UIColor.darkGray
            cell.layer.borderColor = UIColor.black.cgColor
        } else {
            //set the background and text color for the other cells
            cell.backgroundColor = UIColor.black
            cell.layer.borderColor = themeColor.cgColor
        }
        
        //set the label for each cell straight from json
        if indexPath.section == 0 {
            cell.myLabel.text = newsData[indexPath.row]?.time
        } else if indexPath.section == 1 {
            cell.myLabel.text = newsData[indexPath.row]?.headline
        } else if indexPath.section == 2 {
            cell.myLabel.text = newsData[indexPath.row]?.ticker
        } else {
            cell.myLabel.text = newsData[indexPath.row]?.openPrice
        }
        
        return cell
    }
    
    /*
        This function allows the user to see the article in Safari when Headline is pressed
    */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != 0 && indexPath.section == 1 {
            let cell = MyCollectionView.cellForItem(at: indexPath)
            cell?.layer.borderWidth = 2.0
            cell?.layer.backgroundColor = UIColor.gray.cgColor
            
            let url = URL(string: (newsData[indexPath.row]?.articleLink!)!)
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    /*
        This function restores the conditions of the cell after it is deselected
    */
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = MyCollectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 1
        cell?.layer.backgroundColor = UIColor.black.cgColor
    }
    
    /*
        This function allows the user to use the Menu
    */
    @IBAction func MenuPressed(_ sender: Any) {
        menuManager.openMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.barTintColor = themeColor
        
        //preload the Press Release data into collection view
        fetchData()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //show the user the tap on how to read articles when they first log into application
        let userSeenPage = UserDefaults.standard.bool(forKey: "userSeenPage")
        if  !userSeenPage{
            UserDefaults.standard.set(true, forKey: "userSeenPage")
            UserDefaults.standard.synchronize()
            let myAlert = UIAlertController(title: "Note", message: "You can tap on the headlines to open the article", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { action in
                self.dismiss(animated: true, completion: nil)
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        
        //create a daily notifcation for 6:00am
        let content = UNMutableNotificationContent()
        content.title = "FLTR"
        content.body = "See how the stocks in your watch list are doing"
        content.sound = UNNotificationSound.default()
        let currentBadgeNumber = UIApplication.shared.applicationIconBadgeNumber
        content.badge = NSNumber(value: currentBadgeNumber + 1)
        var dateComponents = DateComponents()
        dateComponents.hour = 6
        dateComponents.minute = 0
        let triggerDaily = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "any", content: content, trigger: triggerDaily)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

