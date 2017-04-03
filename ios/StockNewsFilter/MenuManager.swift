//
//  MenuManager.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 3/23/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit

class MenuManager: NSObject, UITableViewDelegate, UITableViewDataSource {

    let tableItems = ["Account", "Watchlist", "Logout"]
    
    let blackView = UIView()
    
    let menuTableView = UITableView()
    
    let navigationController = UINavigationController()
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    /*
        This function sets the amount of columns for our menu
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
        This function sets the amount of rows for our menu
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    /*
        This function creates the menu cells
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        cell.textLabel?.text = tableItems[indexPath.item]
        return cell
    }

    /*
        This function returns the title of our table
    */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Menu"
    }
    
    /*
        This function customizes the height of the table header
    */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return navigationController.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
    }
    
    /*
        This function allows the user to go to a new view controller when an item is selected
    */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var newView: UIViewController
        
        //if last item is selected, then logout; else go to a new view
        if indexPath.row == tableItems.count - 1 {
            newView = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            
            /* This code to create an alert */
            //let alert = UIAlertController(title: "Logout", message: "Are you sure you want to log out", preferredStyle: UIAlertControllerStyle.alert)
            //alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            //alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            //UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        
        } else {
            newView = storyboard.instantiateViewController(withIdentifier: "ResultController") as! MenuItemViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = newView
    }
    
    /*
        This function sets the view for when user presses menu button
    */
    func openMenu() {
        if let window = UIApplication.shared.keyWindow {
            
            //We want to see the current view as a background, with a black tint
            blackView.frame = window.frame
            blackView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            
            //We want to allow the user to close menu when they tap the tinted background
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissMenu)))
            
            //We set the size of our menu
            menuTableView.frame = CGRect(x: 0, y: 0, width: window.frame.width * 3/5, height: window.frame.height)
            
            //Apply subviews as extra layers above NewsFeedView and LeaderboardView
            window.addSubview(blackView)
            window.addSubview(menuTableView)
            
            //Add animation to the sequence for nicer effect
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1
            })
        }
    }
    
    /*
        This function "restores" the view when the user taps outside of menu table
    */
    func dismissMenu() {
        
        //Animate to allow menu to "slide out"
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.menuTableView.frame.origin.x = window.frame.width * -1.0
            }
        })
    }
    
    override init() {
        super.init()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        //menuTableView.isScrollEnabled = false
        menuTableView.bounces = false
        
        menuTableView.register(BaseTableViewCell.classForCoder(), forCellReuseIdentifier: "cellid")
    }
}