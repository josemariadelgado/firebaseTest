//
//  ViewController.swift
//  firebaseTest
//
//  Created by José María Delgado  on 30/7/16.
//  Copyright © 2016 José María Delgado. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(handleLogout))
        
        let launchedBefore = NSUserDefaults.standardUserDefaults().boolForKey("launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
            checkIfUserIsLoggedIn()
        }
        else {
            print("First launch.")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "launchedBefore")
            let signUpController = SignUpController()
            presentViewController(signUpController, animated: true, completion: nil)
        }
    }
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser == nil {
            performSelector(#selector(handleLogout), withObject: nil, afterDelay: 0)
        }
    }
    
    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = SignUpController()
        presentViewController(loginController, animated: true, completion: nil)
    }
}

