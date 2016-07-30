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

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(handleLogout))
        navigationItem.title = "Chema"
    }
    
    func handleLogout() {
        let loginController = LoginController()
        presentViewController(loginController, animated: true, completion: nil)
    }
}

