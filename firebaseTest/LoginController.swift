//
//  LoginController.swift
//  firebaseTest
//
//  Created by José María Delgado Delgado on 31/7/16.
//  Copyright © 2016 José María Delgado. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginController: UIViewController {
    let colors = [UIColor(r:13, g: 144, b: 214),
                  UIColor(r:72, g: 214, b: 129),
                  UIColor(r:214, g: 61, b: 57),
                  UIColor(r:214, g: 91, b: 206),
                  UIColor(r:234, g: 101, b: 16),
                  UIColor(r:140, g: 140, b: 140)]
    
    var backgroundColorCounter = Int(arc4random_uniform(5));
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSizeZero
        view.layer.shadowRadius = 4
        return view
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.layer.borderColor = UIColor(r: 245, g: 245, b: 245).CGColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        textField.font = UIFont.systemFontOfSize(14)
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.layer.borderColor = UIColor(r: 245, g: 245, b: 245).CGColor
        textField.layer.borderColor = UIColor(r: 245, g: 245, b: 245).CGColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        textField.secureTextEntry = true
        textField.font = UIFont.systemFontOfSize(14)
        return textField
    }()
    
    var signInWithYourAccountLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(15)
        label.text = "Sign In With Your Account"
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor(r: 75, g: 75, b: 75)
        return label
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Log in", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(handleLogin), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    lazy var dontHaveAnAccount: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Don't have an account? Sign Up.", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        
//        button.addTarget(self, action: #selector(handleRegisterView), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        var button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        button.addTarget(self, action: #selector(handleCancel), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    func handleCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor(r:50, g: 50, b: 50)
        loginRegisterButton.backgroundColor = UIColor(r:50, g: 50, b: 50)
        
        _ = NSTimer.scheduledTimerWithTimeInterval(
            10.0, target: self, selector: #selector(changeBackgroundColor),
            userInfo: nil, repeats: true)
        
        
        view.addSubview(inputsContainerView)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(loginRegisterButton)
        inputsContainerView.addSubview(emailTextField)
//        view.addSubview(dontHaveAnAccount)
        view.addSubview(cancelButton)
        inputsContainerView.addSubview(signInWithYourAccountLabel)
        setupInputsContainer()
//        setupAlreadyHaveAnAccountButton()
    }
    
    func changeBackgroundColor() {
        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            self.view.backgroundColor = self.colors[self.backgroundColorCounter]
            self.loginRegisterButton.backgroundColor = self.colors[self.backgroundColorCounter]
            self.backgroundColorCounter += 1
            
            if self.backgroundColorCounter == 6 {
                self.backgroundColorCounter = 0
            }
            }, completion:nil)
    }
    
    
    
    func handleLogin() {
        
        guard let email = emailTextField.text, password = passwordTextField.text else {
            print("invalid form")
            return
        }
        
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
            if error != nil{
                print(error)
                return
            }
            let viewController = ViewController()
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
    
    func setupInputsContainer() {
        
        cancelButton.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 10).active = true
        cancelButton.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 25).active = true
        cancelButton.heightAnchor.constraintEqualToConstant(40).active = true
        
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -25).active = true
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -74).active = true
        inputsContainerView.heightAnchor.constraintEqualToConstant(170).active = true
        
        emailTextField.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        emailTextField.bottomAnchor.constraintEqualToAnchor(passwordTextField.topAnchor, constant: -10).active = true
        emailTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        emailTextField.heightAnchor.constraintEqualToConstant(30).active = true
        
        passwordTextField.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        passwordTextField.bottomAnchor.constraintEqualToAnchor(loginRegisterButton.topAnchor, constant: -10).active = true
        passwordTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        passwordTextField.heightAnchor.constraintEqualToConstant(30).active = true
        
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        loginRegisterButton.bottomAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: -10).active = true
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        loginRegisterButton.heightAnchor.constraintEqualToConstant(30).active = true
        
        signInWithYourAccountLabel.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        signInWithYourAccountLabel.bottomAnchor.constraintEqualToAnchor(emailTextField.topAnchor, constant: -15).active = true
        signInWithYourAccountLabel.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        signInWithYourAccountLabel.heightAnchor.constraintEqualToConstant(20).active = true
    }
    
    func setupAlreadyHaveAnAccountButton() {
//        dontHaveAnAccount.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
//        dontHaveAnAccount.topAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: 10).active = true
//        dontHaveAnAccount.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
