//
//  AppDelegate.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 2/9/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit
import UserNotifications
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    /*
        This determines what happens when the app is finished launching.
        If user is logged in, then go straigtht to Press Releases controller
        If user is not logged in, then go straight to LogIn view controller
    */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc: UIViewController
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if !isUserLoggedIn {
            vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        } else {
            vc = storyboard.instantiateViewController(withIdentifier: "NewsNavigationController") as! UINavigationController
        }
        appDelegate.window?.rootViewController = vc
    
        //ask the user if they want notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (allowed, error) in
            //handle code
            if !allowed {
                print("They did not allow notifications")
            }
        }
        
        //check the the notification settings (user can change notification settings any time)
        UNUserNotificationCenter.current().getNotificationSettings{ (settings) in
            if settings.authorizationStatus != UNAuthorizationStatus.authorized {
                //Notifications not allowed
            }
        }
        
        //reset application badge number to 0 when app is open
        //UIApplication.shared.applicationIconBadgeNumber = 0
        
        UNUserNotificationCenter.current().delegate = self
        
        //implementation for facebook
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        return handled
    }
    
    /*
        This application will allow the user to see notifications at the foreground of the application
    */
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

