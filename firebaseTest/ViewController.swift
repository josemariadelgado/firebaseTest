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

class ViewController: UIViewController {
    
    lazy var logoutButton: UIButton = {
        var button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", forState: .Normal)
        button.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        button.setTitleColor(UIColor(r:214, g: 61, b: 57), forState: .Normal)
        button.layer.cornerRadius = 4
        
        button.addTarget(self, action: #selector(handleLogout), forControlEvents: .TouchUpInside)
        return button
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.color = UIColor(r: 50, g: 50, b: 50)
        return activityIndicator
    }()
    
    var usernameLabel: UILabel = {
        var label = UILabel()
        label.text = ""
        label.textColor = UIColor(r: 255, g: 255, b: 255)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.boldSystemFontOfSize(30)
        return label
    }()
    
    lazy var startChatButton: UIButton = {
        var button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start a new chat", forState: .Normal)
        button.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        button.layer.cornerRadius = 4
        
//        button.addTarget(self, action: #selector(handleLogout), forControlEvents: .TouchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBarHidden = true
        
        logoutButton.alpha = 0
        startChatButton.alpha = 0
        
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        view.addSubview(usernameLabel)
        view.addSubview(logoutButton)
        view.addSubview(activityIndicator)
        view.addSubview(startChatButton)
        setupviews()
        
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
        let currentUser = FIRAuth.auth()?.currentUser
        if FIRAuth.auth()?.currentUser == nil {
            performSelector(#selector(handleLogout), withObject: nil, afterDelay: 0)
        } else {
            let ref = FIRDatabase.database().referenceFromURL("https://test-884bc.firebaseio.com/")
            let userReference = ref.child("users").child((currentUser?.uid)!)
            userReference.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                // Get user value
                if let username = snapshot.value!["username"] as? String, let color = snapshot.value!["color"]  as? String{
                    UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                        self.usernameLabel.text = username
                        self.activityIndicator.hidden = true
                        self.activityIndicator.stopAnimating()
                        self.logoutButton.alpha = 1
                        self.startChatButton.alpha = 1
                        }, completion:nil)
                    switch color {
                    case "#0D90D6":
                        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                            self.view.backgroundColor = UIColor(r:13, g: 144, b: 214)
                            self.startChatButton.setTitleColor(UIColor(r:13, g: 144, b: 214), forState: .Normal)
                            }, completion:nil)
                    case "#48D681":
                        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                            self.view.backgroundColor = UIColor(r:72, g: 214, b: 129)
                            self.startChatButton.setTitleColor(UIColor(r:72, g: 214, b: 129), forState: .Normal)
                            }, completion:nil)
                    case "#D63D39":
                        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                            self.view.backgroundColor = UIColor(r:214, g: 61, b: 57)
                            self.startChatButton.setTitleColor(UIColor(r:214, g: 61, b: 57), forState: .Normal)
                            }, completion:nil)
                    case "#D65BCE":
                        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                            self.view.backgroundColor = UIColor(r:214, g: 91, b: 206)
                            self.startChatButton.setTitleColor(UIColor(r:214, g: 91, b: 206), forState: .Normal)
                            }, completion:nil)
                    case "#EA6510":
                        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                            self.view.backgroundColor = UIColor(r:234, g: 101, b: 16)
                            self.startChatButton.setTitleColor(UIColor(r:234, g: 101, b: 16), forState: .Normal)
                            }, completion:nil)
                    case "#8C8C8C":
                        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                            self.view.backgroundColor = UIColor(r:140, g: 140, b: 140)
                            self.startChatButton.setTitleColor(UIColor(r:140, g: 140, b: 140), forState: .Normal)
                            }, completion:nil)
                    default:
                        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
                    }
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    func setUserData() {
        
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let welcomeController = WelcomeViewController()
        presentViewController(welcomeController, animated: true, completion: nil)
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.usernameLabel.text = ""
            self.view.backgroundColor = UIColor(r: 200, g: 200, b: 200)
        }
    }
    
    func setupviews() {
        let screenWidth = view.bounds.width
        
        usernameLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        usernameLabel.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 30).active = true
        usernameLabel.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -74).active = true
        
        
        logoutButton.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 10
            ).active = true
        logoutButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -10).active = true
        logoutButton.widthAnchor.constraintEqualToConstant(screenWidth / 4).active = true
        
        activityIndicator.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        activityIndicator.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        
        startChatButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        startChatButton.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        startChatButton.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -100).active = true
        startChatButton.heightAnchor.constraintEqualToConstant(44).active = true
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        logoutButton.alpha = 0
        checkIfUserIsLoggedIn()
    }
}

