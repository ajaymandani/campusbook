//
//  HomeTableViewCell.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-20.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var dateinfolabel: UILabel!
    @IBOutlet weak var usernamelabel: UILabel!
    @IBOutlet weak var notimsg: UILabel!
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userimg.layer.masksToBounds = true

        userimg.layer.cornerRadius = userimg.frame.height / 2
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    func conifcell(latest:Latest){
        dateinfolabel.text = "\(timeelapsed(latest.date!))"
        usernamelabel.text = latest.receriverName
        notimsg.text = latest.collegeName
        msg.text = latest.programName
        
        if latest.avatarLink != ""{
            FileStorage.downloadImageUrl(imageurl: latest.avatarLink) { img in
                DispatchQueue.main.async {
                    self.userimg.image = img
                }
               
            }
        }else{
            userimg.image = UIImage(systemName: "person.circle.fill")
        }
        
    }
    

}
