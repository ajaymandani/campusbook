//
//  UserTableViewCell.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-18.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var collegeLabel: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var profileimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileimage.layer.masksToBounds = true

        profileimage.layer.cornerRadius = profileimage.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(user:User){
        collegeLabel.text = user.collegeName + " - " +  user.program
        namelabel.text = user.username
        if user.profileImg != ""{
            FileStorage.downloadImageUrl(imageurl: user.profileImg) { img in
                DispatchQueue.main.async {
                    self.profileimage.image = img
                }
               
            }
        }else{
            self.profileimage.image = UIImage(systemName: "person.circle.fill")
        }
       
    }
    
}
