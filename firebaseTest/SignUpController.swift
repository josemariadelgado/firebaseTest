//
//  LoginController.swift
//  firebaseTest
//
//  Created by José María Delgado Delgado on 30/7/16.
//  Copyright © 2016 José María Delgado. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignUpController: UIViewController {
    
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
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
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
        textField.autocapitalizationType = UITextAutocapitalizationType.None
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
        button.setTitle("Sign Up", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(handleRegister), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    lazy var alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Already have an account? Sign In", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        
        button.addTarget(self, action: #selector(handleLoginView), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r:0, g: 200,b: 150)
        
        view.addSubview(inputsContainerView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(loginRegisterButton)
        inputsContainerView.addSubview(usernameTextField)
        view.addSubview(alreadyHaveAnAccountButton)
        setupInputsContainer()
        setupAlreadyHaveAnAccountButton()
    }
    
    func handleLoginView() {
        let loginController = LoginController()
        presentViewController(loginController, animated: true, completion: nil)
    }
    
    func handleRegister() {
        guard let email = emailTextField.text, password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil {
                print(error)
                return
            }
            guard let uid = user?.uid else {
                return
            }
            
            //successfully authenticated user
            let ref = FIRDatabase.database().referenceFromURL("https://test-884bc.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["email": email]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err)
                    return
                }
                
                let homeViewController = ViewController()
                self.presentViewController(homeViewController, animated: true, completion: nil)
                print("Saved user successfully into Firebase db")
                
            })
        })
    }
    
    func setupInputsContainer() {
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -25).active = true
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -74).active = true
        inputsContainerView.heightAnchor.constraintEqualToConstant(200).active = true
        
        usernameTextField.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        usernameTextField.centerYAnchor.constraintEqualToAnchor(inputsContainerView.centerYAnchor, constant: -60).active = true
        usernameTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        usernameTextField.heightAnchor.constraintEqualToConstant(30).active = true
        
        emailTextField.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        emailTextField.centerYAnchor.constraintEqualToAnchor(inputsContainerView.centerYAnchor, constant: -20).active = true
        emailTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        emailTextField.heightAnchor.constraintEqualToConstant(30).active = true
        
        passwordTextField.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        passwordTextField.centerYAnchor.constraintEqualToAnchor(inputsContainerView.centerYAnchor, constant: 20).active = true
        passwordTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        passwordTextField.heightAnchor.constraintEqualToConstant(30).active = true
        
        loginRegisterButton.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        loginRegisterButton.bottomAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: -10).active = true
        loginRegisterButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        loginRegisterButton.heightAnchor.constraintEqualToConstant(30).active = true
    }
    
    func setupAlreadyHaveAnAccountButton() {
        alreadyHaveAnAccountButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        alreadyHaveAnAccountButton.topAnchor.constraintEqualToAnchor(inputsContainerView.bottomAnchor, constant: 10).active = true
        alreadyHaveAnAccountButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
