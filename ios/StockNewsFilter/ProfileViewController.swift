//
//  ProfileViewController.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 3/10/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit
import AVFoundation

class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    //Default username and password for single user
    let username: String = "email"
    let password: String = "password"
    
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
        /*if usernameText.text != username || passwordText.text != password {
            alertLabel.isHidden = false
            alertLabel.textColor = UIColor.red
            alertLabel.text  = "Sorry, you entered an incorrect email address or password"
        } else {*/
            alertLabel.isHidden = true
            let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = myTabBar
        //}
    }
    
    @IBAction func facebookLogIn(_ sender: Any) {
        let url = URL(string: "https://www.facebook.com")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
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
        
        //add toolbar to numberpad
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
        alertLabel.isHidden = true
        
        editKeyboard()
        formatButton(button: loginButton, title: "Log In")
        
        usernameText.frame.size.height = 50.0
        passwordText.frame.size.height = 50.0
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
