//
//  ProfileViewController.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 3/10/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit
import AVFoundation
import FBSDKLoginKit

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var orLabel: UILabel!
    
    /*
        This function deletes the placeholder text, for new attempt
    */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = nil
    }
    
    /*
        This function leaves the user input in the text field
    */
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.placeholder = textField.text
    }
    
    /*
        This function determines if LogIn attempt is successful or not.
        If successful, go to Tab Bar Controller (first view is News Feed).
        If not successful, display error message in red.
    */
    @IBAction func logInButtonTapped(_ sender: Any) {
        let userEmail = usernameText.text
        let userPassword = passwordText.text
        
        let userEmailStored = UserDefaults.standard.string(forKey: "userEmail")
        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword")
        
        //check for empty fields
        if (userEmail?.isEmpty)! || (userPassword?.isEmpty)! {
            //Display alert message
            displayMyAlertMessage(messageTitle: "Missing Fields",userMessage: "All fields are required")
        }
        
        if userEmailStored == userEmail {
            if userPasswordStored == userPassword {
                //Login is successful
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                
                //Go to Press Release View
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = storyboard.instantiateViewController(withIdentifier: "NewsNavigationController") as! UINavigationController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = vc
            } else {
                displayMyAlertMessage(messageTitle: "Incorrect Input", userMessage: "Sorry, you entered an incorrect email address or password")
            }
        } else {
            displayMyAlertMessage(messageTitle: "Incorrect Input", userMessage: "Sorry, you entered an incorrect email address or password")
        }
        
    }
    
    /*
        This function allows logging in through facebook
    */
    @IBAction func facebookLogIn(_ sender: Any) {
        let url = URL(string: "https://www.facebook.com")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    /*
        This function shows the alerts with error messages to the user
    */
    func displayMyAlertMessage(messageTitle: String,userMessage: String){
        let myAlert = UIAlertController(title: messageTitle, message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    /*
        This function will add a Done button to the toolbar that will be attached to a keyboard
        It will also add a flexibleSpace to have the Done button align to the far right
    */
    func editKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil) //set flexibleSpace for Done button
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked)) //set Done button
        
        //add flexibleSpace and Done button to toolbar
        toolbar.setItems([flexibleSpace,doneButton], animated: false)
        
        //add toolbar to keyboard
        usernameText.inputAccessoryView = toolbar
        passwordText.inputAccessoryView = toolbar
    }
    
    /*
        This function will have the toolbar close after clicking Done button
    */
    func doneClicked() {
        view.endEditing(true)
    }
    
    /*
        When called this function will format the button to a circular shape
    */
    func formatButton(button: UIButton, title: String) {
        button.setTitle(title, for: UIControlState.normal)
        button.layer.backgroundColor = UIColor.clear.cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.frame.size.height = 50.0
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        editKeyboard()
        formatButton(button: loginButton, title: "Log In")
        
        usernameText.frame.size.height = 50.0
        passwordText.frame.size.height = 50.0
        
        let facebookLoginButton = FBSDKLoginButton()
        view.addSubview(facebookLoginButton)
        //facebookLoginButton.frame = CGRect(x: 40, y: 505, width: loginButton.frame.width, height: 30)
        facebookLoginButton.frame = CGRect(x: loginButton.frame.origin.x, y: (loginButton.frame.origin.y + signupButton.frame.origin.y) / 2, width: loginButton.frame.width, height: 30)
        facebookLoginButton.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
        facebookLoginButton.delegate = self
        
        orLabel.frame.origin.y = (loginButton.frame.origin.y + facebookLoginButton.frame.origin.y) / 2
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        //check if user already authorized with StockNewsFilter
        if (FBSDKAccessToken.current()) != nil {
            print("Successfully logged in with Facebook")
        
            //Login is successful
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
        
            //Go to Press Release View
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyboard.instantiateViewController(withIdentifier: "NewsNavigationController") as! UINavigationController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = vc
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
