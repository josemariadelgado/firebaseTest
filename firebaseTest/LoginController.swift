//
//  LoginController.swift
//  firebaseTest
//
//  Created by José María Delgado Delgado on 30/7/16.
//  Copyright © 2016 José María Delgado. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    let emailInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextBorderStyle.RoundedRect
        return textField
        }()
    
    let passwordInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextBorderStyle.RoundedRect
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r:94, g: 175,b: 193)
        
        view.addSubview(inputsContainerView)
        inputsContainerView.addSubview(emailInput)
        inputsContainerView.addSubview(passwordInput)
        setupInputsContainer()
    }
    
    func setupInputsContainer() {
        inputsContainerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        inputsContainerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        inputsContainerView.widthAnchor.constraintEqualToAnchor(view.widthAnchor, constant: -74).active = true
        inputsContainerView.heightAnchor.constraintEqualToConstant(150).active = true
        
        emailInput.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        emailInput.centerYAnchor.constraintEqualToAnchor(inputsContainerView.centerYAnchor, constant: -20).active = true
        emailInput.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        emailInput.heightAnchor.constraintEqualToConstant(30).active = true
        
        passwordInput.centerXAnchor.constraintEqualToAnchor(inputsContainerView.centerXAnchor).active = true
        passwordInput.centerYAnchor.constraintEqualToAnchor(inputsContainerView.centerYAnchor, constant: 20).active = true
        passwordInput.widthAnchor.constraintEqualToAnchor(inputsContainerView.widthAnchor, constant: -20).active = true
        passwordInput.heightAnchor.constraintEqualToConstant(30).active = true
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
