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
    
    var financeData = [LeaderboardData]() /* financeData is our array of objects; it is the data used to fill our collection view */
    //var financeData: [LeaderboardData] = []
    /*
    struct Leaderboard {
        
        var ticker: String?
        var volume: String?
        var price: String?
        var percentChange: String?
        var weightedavebasicsharesos: String?
        
        /*
         This is our constructor for the LeaderboardData class; we will use an array of LeaderboardData objects to fill spreadsheet
         */
        
        init(ticker: String, volume: String, price: String, percentChange: String, weightedavebasicsharesos: String) {
            self.ticker = ticker
            self.volume = volume
            self.price = price
            self.percentChange = percentChange
            self.weightedavebasicsharesos = weightedavebasicsharesos
        }
    }

    var financeData: [Leaderboard] = []
    */
    /* The following 5 arrays will be used to create our placeholder data */
    var ticker = ["Ticker",
                  "AFMD",
                  "APHB",
                  "AREX",
                  "ATRA",
                  "AUPH",
                  "AUY",
                  "BLPH",
                  "BOTA",
                  "BPMC",
                  "BPT",
                  "BTG",
                  "CATB",
                  "CERCU",
                  "CERU",
                  "CMCM"]
    var volume = ["Volume",
                  "1260338",
                  "270907",
                  "2753315",
                  "633561",
                  "21892009",
                  "13391995",
                  "1600302",
                  "848395",
                  "753020",
                  "507114",
                  "5144799",
                  "59565706",
                  "4471709",
                  "1893181",
                  "2947477"]
    var price = ["Price",
                 "2.75",
                 "4.75",
                 "2.39",
                 "21",
                 "8.50",
                 "2.64",
                 "1.71",
                 "8",
                 "39.32",
                 "2.99",
                 "2.04",
                 "1.34",
                 "1.78",
                 "1.29",
                 "11.52"]
    var percentChage = ["Percent Change",
                        "0.1224",
                        "0.0532",
                        "0.0814",
                        "0.12",
                        "0.0925",
                        "0.0522",
                        "0.0559",
                        "0.1599",
                        "0.0853",
                        "0.0955",
                        "0.0755",
                        "0.5338000000000001",
                        "0.6438",
                        "0.0857",
                        "0.1414"]
    var weiAveShares = ["Weight Ave Shares",
                        "0",
                        "11120394",
                        "41610083",
                        "28732000",
                        "0",
                        "0",
                        "13854188",
                        "38640487",
                        "27492000",
                        "0",
                        "0",
                        "15512608",
                        "8756393",
                        "27383376",
                        "0"]
    
    /*
        This function will be used to fetch our data from the json
    */
    func fetchData() {
        //self.financeData = [LeaderboardData]()
        
        //data necessary to authenticate into intrino json
        let username = "5e793958db70094110ff45acb40ba08c"
        let password = "6847a450d5fc4e4109e352bb8196b6c7"
        let loginString = String.init(format: "%@:%@", arguments: [username, password])
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        //create the request
        let url = URL(string: "https://api.intrinio.com/securities/search?conditions=volume~gte~250000,percent_change~gte~.05,weightedavebasicsharesos~lte~50000000")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        //let urlConnection = NSURLConnection(request: request, delegate: self)
        let config = URLSessionConfiguration.default
        let authString = "Basic \(base64LoginString)"
        config.httpAdditionalHeaders = ["Authorization": authString]
        
        //log into api with authentication and access json
        let session = URLSession(configuration: config)
        session.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error")
            } else {
                if let content = data {
                    do {
                        //Create our json object within the app
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                        print(myJson) //prints the whole json file
                        
                        if let financialDataFromJson = myJson["data"] as? [[String: AnyObject]] {
                            print(financialDataFromJson) //prints the data array within the json
                            
                            //var count: Int = 0
                            for datafromJson in financialDataFromJson {
                                //let myData = LeaderboardData() /* instance used to create our Leaderboard object */
                                //var myData = [LeaderboardData]()
                                
                                //if let ticker = dataFromJson["ticker"] as? String
                                if let ticker = datafromJson["ticker"] as? String, let volume = datafromJson["volume"] as? String, let percentChange = datafromJson["percent_change"] as? String, let weightedavebasicsharesos = datafromJson["weightedavebasicsharesos"] as? String {
                                    //print(ticker) //prints each ticker
                                    
                                    /* These calls were made without a default constructor */
                                    //myData.ticker = ticker
                                    //myData.volume = volume
                                    //myData.percentChange = percentChange
                                    //myData.weightedavebasicsharesos = weightedavebasicsharesos
                                    
                                    
                                    /* This call creates our LeaderboardData object */
                                    let myData = LeaderboardData(ticker: ticker, volume: volume, price: "0", percentChange: percentChange, weightedavebasicsharesos: weightedavebasicsharesos)
                                    
                                    //let myData = LeaderboardData(ticker: "AAPL", volume: "250000", price: "145.54", percentChange: "0.025", weightedavebasicsharesos: "300000")
                                    
                                    print(ticker) //prints each ticker
                                    print(myData.ticker!)
                                    //print(myData.volume!) //prints each ticker
                                    
                                    /* Each time want to append our instance into financeData array */
                                    self.financeData.append(myData)
                                    //print(self.financeData.count)
                                }
                                //count = count + 1
                                //self.financeData.append(myData)
                            }
                        }
                        DispatchQueue.main.async {
                            self.myCollectionView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            }
            .resume()
    }
    /*
        This function creates our placeholder data (based on our arrays, we will create 16 objects within our financeData array
    */
    //create arbitrary items for data set
    func createitems() -> [LeaderboardData] {
        var items = [LeaderboardData]()
        
        var count: Int = 0
        for _ in ticker {
            items.append(LeaderboardData(ticker: ticker[count], volume: volume[count], price: price[count], percentChange: percentChage[count], weightedavebasicsharesos: weiAveShares[count]))
            count = count + 1
        }
        
        return items
    }
    
    /*
     This function determines the amount of columns.
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //return self.financeData.count
        return 5
    }
    
    /*
     This function determines the amount of rows.
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.financeData.count
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
            cell.myLabel.text = financeData[indexPath.section].ticker
        } else if indexPath.row == 1 {
            cell.myLabel.text = financeData[indexPath.section].volume
        } else if indexPath.row == 2 {
            cell.myLabel.text = financeData[indexPath.section].price
        } else if indexPath.row == 3 {
            cell.myLabel.text = financeData[indexPath.section].percentChange
        } else {
            cell.myLabel.text = financeData[indexPath.section].weightedavebasicsharesos
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
        
        financeData = createitems() //load placeholder data into the collection view
        
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
