//
//  ViewController.swift
//  Techie-Toolkit
//
//  Created by Steve Slack on 22/01/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var activityWheel: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        activityWheel.hidden = true
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    
    }
    
    func showErrorAlert(title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert,animated: true, completion: nil)
        
    }

    @IBAction func submitBtnPressed(sender: AnyObject) {
        activityWheel.hidden = false
        activityWheel.backgroundColor = UIColor.whiteColor()
        activityWheel.startAnimating()
        
        if let username = userName.text where username != "" , let password = pwdField.text where password != "" {
            
        let ref = Firebase(url: FIREBASE_URL)
            ref.authUser(username, password: password, withCompletionBlock: { Error, result in
        
                if Error != nil {
                    
                     self.showErrorAlert("Could not login", msg: "Oops, Something went wrong. Please try again")
                    
                } else {
                    
                    NSUserDefaults.standardUserDefaults().setValue(result.uid, forKey: KEY_UID)
                    self.activityWheel.stopAnimating()
                    self.activityWheel.hidden = true
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
                
        })
            
        }else{
            
            self.showErrorAlert("Could not login", msg: "Please check your username and password")

        }
        
        
    }
    
}

