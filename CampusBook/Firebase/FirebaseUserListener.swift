//
//  FirebaseUserListener.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-18.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseUserListener{
    static let shared = FirebaseUserListener()
    private init(){}
    
    
    func loginUser(email:String,password:String,completion:@escaping(_  error:Error?)->Void){
        Auth.auth().signIn(withEmail: email, password: password) { authData, error in
            if error != nil{
                completion(error)
                return
            }
            completion(nil)
            downloadUserFromFirebase(userId: (authData?.user.uid)!)
            
            
        }
    }
    
    
    func regsiterUser(_email:String,_password:String,username:String,collegeName:String,programName:String,completion:@escaping(_ error:Error?)->Void)
    {
        Auth.auth().createUser(withEmail: _email, password: _password) { authdata, error in
            
            if error != nil{
                completion(error)
                return
            }
            
            if error == nil{
                if authdata?.user != nil{
                    let user = User(id:(authdata?.user.uid)!,username: username,email: _email,profileImg: "", bgImg: "",collegeName: collegeName,program: programName,smallDesc: "Hi, Its Nice to meet you.")
                    saveUserLocal(user: user)
                    self.saveUserOnFirebase(user: user)
                    completion(nil)
                }
            }
            
        }
    }
    func saveUserOnFirebase(user:User){
        do{
            try FirebaseReg(.Users).document(user.id).setData(from: user)
        }catch{
            
        }
        
    }

}



func saveUserLocal(user:User){
    let encode = JSONEncoder()
    do{
        let data = try encode.encode(user)
        UserDefaults.standard.set(data, forKey: KCURRENTUSERS)
    }catch{
        
    }
}

func downloadUserFromFirebase(userId:String,email:String? = nil){
    
    FirebaseReg(.Users).document(userId).getDocument { snap, error in
        
        if let error = error{
            print(error.localizedDescription)
            return
        }
        
        if let snap = snap{
            do{
               let data =  try snap.data(as: User.self)
                saveUserLocal(user: data)
            }catch{
                
            }
        }
        
    }
}


func downloadAllUsers(completion:@escaping(_ alluser:[User]?)->Void){
    
    var users:[User] = []
    FirebaseReg(.Users).limit(to: 100).getDocuments { Snapshot, error in
        if error != nil{
            print(error!.localizedDescription)
            completion(nil)
            return
        }
        let tempusers = Snapshot?.documents.compactMap({ snap -> User in
           return try! snap.data(as: User.self)
        })
        
        for temp in tempusers!{
           if temp.id != User.currentId
            {
               users.append(temp)
           }
            
        }
        
        completion(users)
        
    }
    
}


func downloadUserFromFirebase(withId:[String],completion: @escaping(_ allUsers:[User]?)->Void )
{
    var count = 0
    var userArray:[User] = []
    for userid in withId{
        FirebaseReg(.Users).document(userid).getDocument { SnapshotDat, error in
            
            if error != nil{
                completion(nil)
                print(error!.localizedDescription)
                return
            }
            
            let user = try? SnapshotDat?.data(as: User.self)
            userArray.append(user!)
            count+=1
            
            if(count == withId.count)
            {
                completion(userArray)
            }
            
        }
    }
}
