//
//  SignUpViewController.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-18.
//

import UIKit
import ProgressHUD
class SignUpViewController: UIViewController {

    @IBOutlet weak var programField: UITextField!
    @IBOutlet weak var collegeNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var namefield: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.attributedPlaceholder = NSAttributedString(string: "enter your email",attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        
        namefield.attributedPlaceholder = NSAttributedString(string: "enter your full name",attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        
        passwordField.attributedPlaceholder = NSAttributedString(string: "enter your password",attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        
        collegeNameField.attributedPlaceholder = NSAttributedString(string: "enter your college name",attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        
        programField.attributedPlaceholder = NSAttributedString(string: "enter your program eg:- Management Program",attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        
        
   
        
    }
    

    @IBAction func signUpBtn(_ sender: UIButton) {
        
        if(emailField.text != "" && namefield.text != "" && passwordField.text != "" && collegeNameField.text != "" && programField.text != "")
        {
            FirebaseUserListener.shared.regsiterUser(_email: emailField.text!, _password: passwordField.text!, username: namefield.text!, collegeName: collegeNameField.text!, programName: programField.text!) { error in
                if let error = error{
                    ProgressHUD.showError(error.localizedDescription)
                }else{
                    ProgressHUD.showSucceed("Reigstered, Please try to login.")
                }
            }
          
        }else{
            ProgressHUD.showError("Please fill all the field!!")
        }
    }
    
    
   

}
