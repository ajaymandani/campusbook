//
//  GotoProfileViewController.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-20.
//

import UIKit
import ProgressHUD
class GotoProfileViewController: UIViewController {
    @IBOutlet weak var bgimg: UIImageView!
    
    @IBOutlet weak var smalldesc: UILabel!
    @IBOutlet weak var program: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var collegeName: UILabel!
    var user:User!
    override func viewDidLoad() {
        super.viewDidLoad()

        userimage.layer.masksToBounds = true

        userimage.layer.cornerRadius = userimage.frame.height / 2

        let backbtn = UIBarButtonItem(title: "Go Back to Users", style: .plain, target: self, action: #selector(goback))
        backbtn.tintColor = .white
        navigationItem.leftBarButtonItem = backbtn
        
        
        smalldesc.text = user.smallDesc
        program.text = user.program
        username.text = user.username
        collegeName.text = user.collegeName
        
        if(user.profileImg != ""){
            
            FileStorage.downloadImageUrl(imageurl: user.profileImg) { img in
                DispatchQueue.main.async {
                    self.userimage.image = img
                }
               
            }
            
        }else{
            userimage.image = UIImage(systemName: "person.circle.fill")
        }
        
        if(user.bgImg != ""){
            
            FileStorage.downloadImageUrl(imageurl: user.bgImg) { img in
                DispatchQueue.main.async {
                    self.bgimg.image = img
                }
               
            }
            
        }else{
            bgimg.image = UIImage(named: "bg")
        }

    }
    
    @objc func goback(){
        
        self.navigationController?.popViewController(animated: true)
    }
 
    

    @IBAction func startAddContact(_ sender: UIButton) {
        ProgressHUD.showSucceed("added on the home screen")
       _ =  startchat(user1: User.currentUser!, user2: user)
    }
}
