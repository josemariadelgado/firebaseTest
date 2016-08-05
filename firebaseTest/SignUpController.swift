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
    let bluecolor: UIColor = UIColor(r:13, g: 144, b: 214)
    let greenColor: UIColor = UIColor(r:72, g: 214, b: 129)
    let redColor: UIColor = UIColor(r:214, g: 61, b: 57)
    let pinkColor: UIColor = UIColor(r:214, g: 91, b: 206)
    let orangeColor: UIColor = UIColor(r:234, g: 101, b: 16)
    let grayColor: UIColor = UIColor(r:140, g: 140, b: 140)
    var selectedColor: String! = ""
    
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
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
        textField.layer.cornerRadius = 4
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
        textField.layer.cornerRadius = 4
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
        textField.layer.cornerRadius = 4
        textField.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        textField.secureTextEntry = true
        textField.font = UIFont.systemFontOfSize(14)
        return textField
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(r:100, g: 100, b: 100)
        button.setTitle("Sign Up", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        button.layer.cornerRadius = 3
        
        button.addTarget(self, action: #selector(handleRegister), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    lazy var alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Already have an account? Sign In.", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        
        button.addTarget(self, action: #selector(handleLoginView), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    var creatYourAccountLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(15)
        label.text = "Create Your New Account"
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor(r: 75, g: 75, b: 75)
        return label
    }()
    
    var chooseColorLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFontOfSize(12)
        label.text = "Choose your color"
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor(r: 255, g: 255, b: 255)
        return label
    }()
    
    var chooseColorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var blueColorButton: UIButton = {
        var button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(r:13, g: 144, b: 214)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(r: 255, g: 255, b: 255).CGColor
        
        button.addTarget(self, action: #selector(chooseColor), forControlEvents: .TouchUpInside)
        return button
        
    }()
    
    lazy var greenColorButton: UIButton = {
        var button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(r:72, g: 214, b: 129)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(r: 255, g: 255, b: 255).CGColor
        
        button.addTarget(self, action: #selector(chooseColor), forControlEvents: .TouchUpInside)
        return button
        
    }()
    
    lazy var redColorButton: UIButton = {
        var button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(r:214, g: 61, b: 57)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(r: 255, g: 255, b: 255).CGColor
        
        button.addTarget(self, action: #selector(chooseColor), forControlEvents: .TouchUpInside)
        return button
        
    }()
    
    lazy var pinkColorButton: UIButton = {
        var button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(r:214, g: 91, b: 206)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(r: 255, g: 255, b: 255).CGColor
        
        button.addTarget(self, action: #selector(chooseColor), forControlEvents: .TouchUpInside)
        return button
        
    }()
    
    lazy var orangeColorButton: UIButton = {
        var button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(r:234, g: 101, b: 16)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(r: 255, g: 255, b: 255).CGColor
        
        button.addTarget(self, action: #selector(chooseColor), forControlEvents: .TouchUpInside)
        return button
        
    }()
    
    lazy var grayColorButton: UIButton = {
        var button = UIButton(type: .System)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(r:140, g: 140, b: 140)
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor(r: 255, g: 255, b: 255).CGColor
        
        button.addTarget(self, action: #selector(chooseColor), forControlEvents: .TouchUpInside)
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
        self.hideKeyboard()
        
        view.backgroundColor = UIColor(r:50, g: 50, b: 50)
        
        if view.backgroundColor == UIColor(r:50, g: 50, b: 50) {
            inputsContainerView.hidden = true
            inputsContainerView.alpha = 0
        }
        
        loginRegisterButton.enabled = false
        loginRegisterButton.alpha = 0.3
        
        
        usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange), forControlEvents: UIControlEvents.EditingChanged)
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), forControlEvents: UIControlEvents.EditingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), forControlEvents: UIControlEvents.EditingChanged)
        
        view.addSubview(inputsContainerView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(loginRegisterButton)
        inputsContainerView.addSubview(usernameTextField)
        inputsContainerView.addSubview(creatYourAccountLabel)
//        view.addSubview(alreadyHaveAnAccountButton)
        view.addSubview(chooseColorLabel)
        view.addSubview(chooseColorView)
        view.addSubview(cancelButton)
        chooseColorView.addSubview(blueColorButton)
        chooseColorView.addSubview(greenColorButton)
        chooseColorView.addSubview(redColorButton)
        chooseColorView.addSubview(pinkColorButton)
        chooseColorView.addSubview(orangeColorButton)
        chooseColorView.addSubview(grayColorButton)
        setupInputsContainer()
//        setupAlreadyHaveAnAccountButton()
        setupChooseColorView()
    }
    
    func handleLoginView() {
        let loginController = LoginController()
        presentViewController(loginController, animated: true, completion: nil)
    }
    
    func handleRegister() {
        guard let email = emailTextField.text, password = passwordTextField.text, username = usernameTextField.text else {
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil {
                switch error?.code {
                case 17007?:
                    self.alertView("Error Signing Up", message: "The email address is already in use by another account." , actionTitle: "Ok")
                case 17008?:
                    self.alertView("Error Signing Up", message: "The email address is badly formatted, enter a valid email address (example@email.com)." , actionTitle: "Ok")
                default:
                    self.alertView("Error Signing Up", message: "An unknown error has occured :(. Please, try again later." , actionTitle: "Ok")
                }
                print(error)
                return
            }
            guard let uid = user?.uid else {
                return
            }
            
            //successfully authenticated user
            let ref = FIRDatabase.database().referenceFromURL("https://test-884bc.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["email": email, "username": username, "color": self.selectedColor]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err)
                    return
                }
                
                let viewController = ViewController()
                self.presentViewController(viewController, animated: true, completion: nil)
                print("Saved user successfully into Firebase db")
                
            })
        })
    }
    
    func alertView(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func setupInputsContainer() {
        
        cancelButton.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 10).active = true
        cancelButton.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 25).active = true
        cancelButton.heightAnchor.constraintEqualToConstant(40).active = true
        
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -40).active = true
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -74).active = true
        inputsContainerView.heightAnchor.constraintEqualToConstant(210).active = true
        
        creatYourAccountLabel.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        creatYourAccountLabel.bottomAnchor.constraintEqualToAnchor(usernameTextField.topAnchor, constant: -15).active = true
        creatYourAccountLabel.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
        creatYourAccountLabel.heightAnchor.constraintEqualToConstant(20).active = true
        
        usernameTextField.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        usernameTextField.bottomAnchor.constraintEqualToAnchor(emailTextField.topAnchor, constant: -10).active = true
        usernameTextField.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        usernameTextField.heightAnchor.constraintEqualToConstant(30).active = true
        
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
    }
    
    func setupAlreadyHaveAnAccountButton() {
//        alreadyHaveAnAccountButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
//        alreadyHaveAnAccountButton.bottomAnchor.constraintEqualToAnchor(chooseColorLabel.bottomAnchor, constant: -30).active = true
//        alreadyHaveAnAccountButton.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor).active = true
    }
    
    func setupChooseColorView() {
        
        chooseColorLabel.bottomAnchor.constraintEqualToAnchor(blueColorButton.topAnchor, constant: -10).active = true
        chooseColorLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        chooseColorLabel.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -74).active = true
        
        chooseColorView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        chooseColorView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -20).active = true
        chooseColorView.widthAnchor.constraintEqualToConstant(290).active = true
        chooseColorView.heightAnchor.constraintEqualToConstant(40).active = true
        
        blueColorButton.leftAnchor.constraintEqualToAnchor(chooseColorView.leftAnchor).active = true
        blueColorButton.bottomAnchor.constraintEqualToAnchor(chooseColorView.bottomAnchor).active = true
        blueColorButton.widthAnchor.constraintEqualToConstant(40).active = true
        blueColorButton.heightAnchor.constraintEqualToConstant(40).active = true
        
        greenColorButton.leftAnchor.constraintEqualToAnchor(blueColorButton.rightAnchor, constant: 10).active = true
        greenColorButton.bottomAnchor.constraintEqualToAnchor(chooseColorView.bottomAnchor).active = true
        greenColorButton.widthAnchor.constraintEqualToConstant(40).active = true
        greenColorButton.heightAnchor.constraintEqualToConstant(40).active = true
        
        redColorButton.leftAnchor.constraintEqualToAnchor(greenColorButton.rightAnchor, constant: 10).active = true
        redColorButton.bottomAnchor.constraintEqualToAnchor(chooseColorView.bottomAnchor).active = true
        redColorButton.widthAnchor.constraintEqualToConstant(40).active = true
        redColorButton.heightAnchor.constraintEqualToConstant(40).active = true
        
        pinkColorButton.leftAnchor.constraintEqualToAnchor(redColorButton.rightAnchor, constant: 10).active = true
        pinkColorButton.bottomAnchor.constraintEqualToAnchor(chooseColorView.bottomAnchor).active = true
        pinkColorButton.widthAnchor.constraintEqualToConstant(40).active = true
        pinkColorButton.heightAnchor.constraintEqualToConstant(40).active = true
        
        orangeColorButton.leftAnchor.constraintEqualToAnchor(pinkColorButton.rightAnchor, constant: 10).active = true
        orangeColorButton.bottomAnchor.constraintEqualToAnchor(chooseColorView.bottomAnchor).active = true
        orangeColorButton.widthAnchor.constraintEqualToConstant(40).active = true
        orangeColorButton.heightAnchor.constraintEqualToConstant(40).active = true
        
        grayColorButton.rightAnchor.constraintEqualToAnchor(chooseColorView.rightAnchor).active = true
        grayColorButton.bottomAnchor.constraintEqualToAnchor(chooseColorView.bottomAnchor).active = true
        grayColorButton.widthAnchor.constraintEqualToConstant(40).active = true
        grayColorButton.heightAnchor.constraintEqualToConstant(40).active = true
    }
    
    func chooseColor() {
        if blueColorButton.touchInside {
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                self.view.backgroundColor = self.bluecolor
                self.loginRegisterButton.backgroundColor = self.bluecolor
                self.inputsContainerView.hidden = false
                self.inputsContainerView.alpha = 1
                }, completion:nil)
            self.selectedColor = "#0D90D6"
        } else if greenColorButton.touchInside {
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                self.view.backgroundColor = self.greenColor
                self.loginRegisterButton.backgroundColor = self.greenColor
                self.inputsContainerView.hidden = false
                self.inputsContainerView.alpha = 1
                }, completion:nil)
            self.selectedColor = "#48D681"
        } else if redColorButton.touchInside {
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                self.view.backgroundColor = self.redColor
                self.loginRegisterButton.backgroundColor = self.redColor
                self.inputsContainerView.hidden = false
                self.inputsContainerView.alpha = 1
                }, completion:nil)
            self.selectedColor = "#D63D39"
        } else if pinkColorButton.touchInside {
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                self.view.backgroundColor = self.pinkColor
                self.loginRegisterButton.backgroundColor = self.pinkColor
                self.inputsContainerView.hidden = false
                self.inputsContainerView.alpha = 1
                }, completion:nil)
            self.selectedColor = "#D65BCE"
        } else if orangeColorButton.touchInside {
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                self.view.backgroundColor = self.orangeColor
                self.loginRegisterButton.backgroundColor = self.orangeColor
                self.inputsContainerView.hidden = false
                self.inputsContainerView.alpha = 1
                }, completion:nil)
            self.selectedColor = "#EA6510"
        } else if grayColorButton.touchInside {
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                self.view.backgroundColor = self.grayColor
                self.loginRegisterButton.backgroundColor = self.grayColor
                self.inputsContainerView.hidden = false
                self.inputsContainerView.alpha = 1
                }, completion:nil)
            self.selectedColor = "#8C8C8C"
        }
    }
    
    func usernameTextFieldDidChange() {
        if usernameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" || usernameTextField.text?.characters.count < 3 || passwordTextField.text?.characters.count < 6{
            loginRegisterButton.enabled = false
            loginRegisterButton.alpha = 0.3
        } else {
            loginRegisterButton.enabled = true
            loginRegisterButton.alpha = 1
        }
    }
    
    func emailTextFieldDidChange() {
        if usernameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" || usernameTextField.text?.characters.count < 3 || passwordTextField.text?.characters.count < 6{
            loginRegisterButton.enabled = false
            loginRegisterButton.alpha = 0.3
        } else {
            loginRegisterButton.enabled = true
            loginRegisterButton.alpha = 1
        }
    }
    
    func passwordTextFieldDidChange() {
        if usernameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" || usernameTextField.text?.characters.count < 3 || passwordTextField.text?.characters.count < 6 {
            loginRegisterButton.enabled = false
            loginRegisterButton.alpha = 0.3
        } else {
            loginRegisterButton.enabled = true
            loginRegisterButton.alpha = 1
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
