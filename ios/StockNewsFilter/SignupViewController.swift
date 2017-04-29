//
//  SignupViewController.swift
//  StockNewsFilter
//
//  Created by Aaron Sargento on 3/28/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var alreadyUserButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    

    /*
        This handles the case if individual is already a user
    */
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
        This function handles the registration process
    */
    @IBAction func registerButtonTapped(_ sender: Any) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        //check for empty fields
        if (userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)! {
            //Display alert message
            displayMyAlertMessage(messageTitle: "Missing Fields", userMessage: "All fields are required")
        }
        
        //check if passwords match
        if userPassword != userRepeatPassword {
            //Display alert message
            displayMyAlertMessage(messageTitle: "Mismatched Passwords", userMessage: "Passwords do not match")
        }
        
        //store data (temporarily on user side)
        UserDefaults.standard.set(userEmail, forKey: "userEmail")
        UserDefaults.standard.set(userPassword, forKey: "userPassword")
        UserDefaults.standard.synchronize()
        
        //display alert message with confirmation
        let myAlert = UIAlertController(title: "Registration Successful!", message: "Registration is successful. Thank you.", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
        }
    /*
        This function shows the alerts with error messages to user.
    */
    func displayMyAlertMessage(messageTitle: String, userMessage: String){
        let myAlert = UIAlertController(title: messageTitle, message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
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
        userEmailTextField.inputAccessoryView = toolbar
        userPasswordTextField.inputAccessoryView = toolbar
        repeatPasswordTextField.inputAccessoryView = toolbar
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
        
        formatButton(button: registrationButton, title: "Create an account")
        
        userEmailTextField.frame.size.height = 50.0
        userPasswordTextField.frame.size.height = 50.0
        repeatPasswordTextField.frame.size.height = 50.0
        
        orLabel.frame.origin.y = (registrationButton.frame.origin.y + alreadyUserButton.frame.origin.y) / 2
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
