//
//  WelcomeViewController.swift
//  firebaseTest
//
//  Created by José María Delgado  on 5/8/16.
//  Copyright © 2016 José María Delgado. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
    var welcomLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome!"
        label.font = UIFont.boldSystemFontOfSize(30)
        label.textColor = UIColor(r: 255, g: 255, b: 255)
        label.textAlignment = NSTextAlignment.Center
        
        return label
    }()
    
    lazy var signInButton: UIButton = {
        var button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button.addTarget(self, action: #selector(handleSignInView), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        var button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign up", forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        button.setTitleColor(UIColor(r:50, g: 50, b: 50), forState: .Normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.whiteColor()
        
        
        button.addTarget(self, action: #selector(handleSignUpView), forControlEvents: .TouchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r:50, g: 50, b: 50)
        navigationController?.navigationBarHidden = true
        
        if FIRAuth.auth()?.currentUser != nil {
            let viewController = ViewController()
            presentViewController(viewController, animated: true, completion: nil)
        }
        
        view.addSubview(welcomLabel)
        view.addSubview(signUpButton)
        view.addSubview(signInButton)
        setupViews()
    }
    
    func handleSignInView() {
        let signInController = LoginController()
        presentViewController(signInController, animated: true, completion: nil)
    }
    
    func handleSignUpView() {
        let signUpController = SignUpController()
        presentViewController(signUpController, animated: true, completion: nil)
    }
    
    func setupViews() {
        welcomLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        welcomLabel.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -100).active = true
        welcomLabel.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        
        signUpButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        signUpButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -25).active = true
        signUpButton.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -100).active = true
        signUpButton.heightAnchor.constraintEqualToConstant(44).active = true
        
        signInButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        signInButton.bottomAnchor.constraintEqualToAnchor(signUpButton.topAnchor, constant: -25).active = true
        signInButton.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        
        
        
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}
