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
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(r: 0, g: 200, b: 150)
        button.setTitle("Login", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(handleLogin), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    lazy var dontHaveAnAccount: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Don't have an account? Sign Up", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        
        button.addTarget(self, action: #selector(handleRegisterView), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    func handleRegisterView() {
        let signUpController = SignUpController()
        presentViewController(signUpController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r:0, g: 200,b: 150)
        
        view.addSubview(inputsContainerView)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(loginRegisterButton)
        inputsContainerView.addSubview(emailTextField)
        view.addSubview(dontHaveAnAccount)
        setupInputsContainer()
        setupAlreadyHaveAnAccountButton()
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
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func setupInputsContainer() {
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -25).active = true
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -74).active = true
        inputsContainerView.heightAnchor.constraintEqualToConstant(150).active = true
        
        emailTextField.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        emailTextField.centerYAnchor.constraintEqualToAnchor(inputsContainerView.centerYAnchor, constant: -40).active = true
        emailTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        emailTextField.heightAnchor.constraintEqualToConstant(30).active = true
        
        passwordTextField.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        passwordTextField.centerYAnchor.constraintEqualToAnchor(inputsContainerView.centerYAnchor).active = true
        passwordTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        passwordTextField.heightAnchor.constraintEqualToConstant(30).active = true
        
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        loginRegisterButton.bottomAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: -10).active = true
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        loginRegisterButton.heightAnchor.constraintEqualToConstant(30).active = true
    }
    
    func setupAlreadyHaveAnAccountButton() {
        dontHaveAnAccount.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        dontHaveAnAccount.topAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: 10).active = true
        dontHaveAnAccount.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
