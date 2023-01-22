//
//  Users.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-18.
//

import Foundation
import FirebaseAuth
struct User:Codable,Equatable{
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    var id = ""
    var username = ""
    var email = ""
    var pushNotifyIdentifier = ""
    var profileImg = ""
    var bgImg = ""
    var collegeName = ""
    var program = ""
    var smallDesc = ""
    
    static var currentId:String{
        return Auth.auth().currentUser!.uid
    }
    
    static var currentUser:User?{
        
        if Auth.auth().currentUser != nil{
           if let currUser = UserDefaults.standard.data(forKey: KCURRENTUSERS)
            {
               let decoder = JSONDecoder()
               do{
                   return try decoder.decode(User.self, from: currUser)
               }catch{
                   
               }
           }
            
        }
        return nil
        
        
    }
    
    
    
}
