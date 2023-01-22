//
//  WelcomeViewController.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-18.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "SignUpSegue", sender: nil)

    }
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signInSegue", sender: nil)

    }
}
