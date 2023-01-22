//
//  EditProfileViewController.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-18.
//

import UIKit
import Gallery
class EditProfileViewController: UIViewController, UITextFieldDelegate, GalleryControllerDelegate {
    
    
    var bg = 0
    @IBOutlet weak var updateProfileBtn: UIButton!
    @IBOutlet weak var updateBackgroundBtn: UIButton!
    @IBOutlet weak var smallDescField: UITextField!
    @IBOutlet weak var programNameField: UITextField!
    @IBOutlet weak var collegeNameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    var gallery:GalleryController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smallDescField.attributedPlaceholder = NSAttributedString(string: "enter a small description",attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        
        programNameField.attributedPlaceholder = NSAttributedString(string: "update your program name",attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        
        collegeNameField.attributedPlaceholder = NSAttributedString(string: "update your college name",attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        
        nameField.attributedPlaceholder = NSAttributedString(string: "update your name",attributes: [NSAttributedString.Key.foregroundColor:UIColor.gray,.font: UIFont.boldSystemFont(ofSize: 14.0)])
        
        
        smallDescField.delegate = self
        programNameField.delegate = self
        collegeNameField.delegate = self
        nameField.delegate = self
        
        smallDescField.tag = 0
        programNameField.tag = 1
        collegeNameField.tag = 2
        nameField.tag = 3
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUserView()
    }
    
    
    func  updateUserView(){
        if let user = User.currentUser {
            collegeNameField.text = user.collegeName
            programNameField.text = user.program
            nameField.text = user.username
            smallDescField.text = user.smallDesc
            if user.profileImg != ""{
                
            }
            
            if user.bgImg != ""{
                
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if var user = User.currentUser{
            if textField.text != ""{
                if(textField.tag == 0)
                {
                    user.smallDesc = smallDescField.text!
                }else if(textField.tag == 1)
                {
                    user.program = programNameField.text!
                }else if(textField.tag == 2)
                {
                    user.collegeName = collegeNameField.text!
                }else if(textField.tag == 3)
                {
                    user.username = nameField.text!
                }
                
                saveUserLocal(user: user)
                FirebaseUserListener.shared.saveUserOnFirebase(user: user)
            }
            
        }
        
        
        return textField.endEditing(true)
    }
    
    @IBAction func updateBackground(_ sender: UIButton) {
        bg = 1
        openGallery()
    }
    @IBAction func updateProfile(_ sender: UIButton) {
        bg = 0
        openGallery()
    }
    @IBAction func saveBtn(_ sender: UIButton) {
    }
    func openGallery(){
        gallery = GalleryController()
        gallery.delegate = self
        Config.initialTab = .imageTab
        Config.tabsToShow = [.imageTab,.cameraTab]
        Config.Camera.imageLimit = 1
        
        self.present(gallery, animated: true)
        
        
    }
    
    
    
    func galleryController(_ controller: Gallery.GalleryController, didSelectImages images: [Gallery.Image]) {
        if images.count > 0{
            images.first?.resolve(completion: { img in
                if img != nil{
                    var loc = ""
                    if self.bg == 0{
                        loc = "Profile/_\(User.currentUser!.id).jpg"
                    }else
                    {
                        loc = "Profile/_bg\(User.currentUser!.id).jpg"
                    }
                    DispatchQueue.main.async {
                        FileStorage.saveUserImage(image: img!,location: loc) { docString in
                            if docString == nil{
                                print("not doun erro")
                                return
                            }
                            if var user = User.currentUser{
                                if self.bg == 0{
                                    user.profileImg = docString!

                                }else{
                                    user.bgImg = docString!

                                }
                                saveUserLocal(user: user)
                                FirebaseUserListener.shared.saveUserOnFirebase(user: user)
                                FileStorage.saveFileLocally(filedata: img!.jpegData(compressionQuality: 1)! as NSData, filename: self.bg == 0 ? "\(User.currentUser!.id)" : "bg\(User.currentUser!.id)")
                            }
                            
                        }
                    }
                 
                }
            })
        }
        controller.dismiss(animated: true)
    }
    
    func galleryController(_ controller: Gallery.GalleryController, didSelectVideo video: Gallery.Video) {
        controller.dismiss(animated: true)
    }
    
    func galleryController(_ controller: Gallery.GalleryController, requestLightbox images: [Gallery.Image]) {
        controller.dismiss(animated: true)
    }
    
    func galleryControllerDidCancel(_ controller: Gallery.GalleryController) {
        controller.dismiss(animated: true)
    }
    
}
