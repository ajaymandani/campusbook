//
//  SignInViewController.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-18.
//

import UIKit
import ProgressHUD
class SignInViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

 
        passwordField.attributedPlaceholder = NSAttributedString(string: "enter your password",attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        
        emailField.attributedPlaceholder = NSAttributedString(string: "enter your email",attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 14.0)])
    }
    

  
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        
        if(emailField.text != "" && passwordField.text != "" )
        {
            FirebaseUserListener.shared.loginUser(email: emailField.text!, password: passwordField.text!, completion: { error in
               
                if let error = error{
                    print("here2")
                    ProgressHUD.showError(error.localizedDescription)
                    return
                }else{
                    DispatchQueue.main.async {
                        ProgressHUD.showSucceed("Welcome")
                        self.enter()
                    }

                   
                }
              
                
            })
          
        }else{
            ProgressHUD.showError("Please fill all the field!!")
        }
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "SignUpSegue", sender: nil)

    }
    func  enter(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home") as! UITabBarController

        storyboard.modalPresentationStyle = .fullScreen

        self.present(storyboard, animated: true)
        
    }
}
