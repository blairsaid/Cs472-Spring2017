//
//  HelpViewController.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 4/18/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var helpTextView: UITextView!
    
    let themeColor = UIColor(red: 95/255, green: 207/255, blue: 153/255, alpha: 1)
    let menuManager = MenuManager()
    
    //this will be our tips for 'How To Use FlTR'
    let htmlString: String = "<font face=\"MarkerFelt\"><font size =\"6\"><font color=\"themeColor\">Introduction" + "\n" +
    "<br /><font face=\"HelveticaNeue\"><font size =\"4\"><font color=\"white\">Let this guide be an updatable and work-in-progress as the strategy gets finely tuned over the progression and development of this strategy. The two main components of this strategy will serve as a starting guide to the journey of any novice stock trader. These two main components are the: Press Releases and Leaderboard." + "\n\n" +
    "<br /><br /><font face=\"MarkerFelt\"><font size =\"6\"><font color=\"themeColor\">Press Releases" + "\n" +
    "<br /><font face=\"HelveticaNeue\"><font size =\"4\"><font color=\"white\">What is the &quot;Press Releases&quot; section? This section is a curated list of press releases that are hand crafted and curated using a proprietary algorithm which we built to find press releases that meet a certain criteria of &quot;keywords&quot; within the title. These keywords are generally known to spike a stock easily from 50 cents to a few dollars over the course of a few days. We&apos;ve hand selected the keywords that will be filtered through the apps curation process for now, and have futures updates that will allow you to enter the keywords of your choice." + "\n\n" +
    "<br /><br /><font face=\"MarkerFelt\"><font size =\"6\"><font color=\"themeColor\">Leaderboard" + "\n" +
    "<br /><font face=\"HelveticaNeue\"><font size =\"4\"><font color=\"white\">What is the &quot;Leaderboard&quot;? The leaderboard is a compilation of stocks that are likely to have risen and had volatile movement on the price of their stock today by 3 simple criteria: i) Low float (under 50,000,000 shares), ii) 5 Percent Change or more on the day, and iii) Volume greater than 250,000 shares traded for that day." + "\n\n" +
    "<br /><br /><font face=\"HelveticaNeue\"><font size =\"4\"><font color=\"white\">The reason why these stocks show up in the Leaderboard section is because these generally have the highest odds of making these biggest moves of subsequent days that follow. Again, these criteria usually pick stocks that are volatile, have already shown a big percent gain, and have a user interest by the sheer amount of volume that has been traded on it for the day." + "\n\n" +
    "<br /><br /><font face=\"MarkerFelt\"><font size =\"6\"><font color=\"themeColor\">Watch Lists" + "\n" +
    "<br /><font face=\"HelveticaNeue\"><font size =\"4\"><font color=\"white\">This section is here for you to pick or add stocks that you feel want to highlight out from the Leaderboard and/or Press Releases. This is strictly as a tool to help make these features more predominant." + "\n\n" +
    "<br /><br /><font face=\"MarkerFelt\"><font size =\"6\"><font color=\"themeColor\">Purpose of FLTR" + "\n" +
    "<br /><font face=\"HelveticaNeue\"><font size =\"4\"><font color=\"white\">This section and scope really goes beyond the ability of this application. This application can only serve as a vehicle for delivering content that &quot;becomes playable&quot;, meaning, stocks that you should be watching. However, identifying exactly when to trade in and out of these plays is something that cannot be easily conveyed through reading of the paragraphs, and it is more important to focus on the overall strategy at large: each morning press releases come out, and certain press releases contain more &quot;weight&quot; in terms of activity and volatility. It is solely up to your discretion whether you feel this press release has enough validity in order to trade."
    
    /*
        This function will allow the user to use the Menu
    */
    @IBAction func MenuPressed(_ sender: Any) {
        menuManager.openMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.barTintColor = themeColor
        
        //preload the tips into the view controller
        let encodedData = htmlString.data(using: String.Encoding.utf8)!
        let attributedOptions = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            helpTextView.attributedText = attributedString
            
        } catch _ {
            print("Cannot create attributed String")
        }
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
