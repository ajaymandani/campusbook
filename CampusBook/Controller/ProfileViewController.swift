//
//  ProfileViewController.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-18.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var smallDescLabel: UILabel!
    @IBOutlet weak var programLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var collegeName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.masksToBounds = true

        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUserView()
    }
    

    @IBAction func editProfileBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "editProfileSegue", sender: nil)
    }
    
    func  updateUserView(){
        if let user = User.currentUser {
            collegeName.text = user.collegeName
            programLabel.text = user.program
            nameLabel.text = user.username
            smallDescLabel.text = user.smallDesc
            if user.profileImg != ""{
                FileStorage.downloadImageUrl(imageurl: user.profileImg) { img in
                    DispatchQueue.main.async {
                        self.profileImage.image = img
                    }
                    
                }
            }
            
            if user.bgImg != ""{
                FileStorage.downloadImageUrl(imageurl: user.bgImg) { img in
                    DispatchQueue.main.async {
                        self.bgImage.image = img
                    }
                    
                }
            }
        }
    }
    

}
