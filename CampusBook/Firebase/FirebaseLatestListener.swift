//
//  FirebaseLatestListener.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-21.
//

import Foundation
import FirebaseFirestore


class FirebaseLatestListener{
    static let shared = FirebaseLatestListener()
    private init(){}
    
    func downloadAllLatestfromfirestore(completion:@escaping(_ latest:[Latest]?)->Void)
    {
        FirebaseReg(.Latest).whereField("senderId", isEqualTo: User.currentId).addSnapshotListener { snap, error in
            
            if error != nil{
                completion(nil)
                return
            }
            
            if snap!.documents.isEmpty{
                completion(nil)
                return
            }
            
            var latestfire:[Latest] = []
            let allres = snap!.documents.compactMap { query -> Latest? in
                do{
                    return try query.data(as: Latest.self)
                }catch{
                    print("error found")
                    print(error.localizedDescription)
                }
               return nil
                
            }
            
            for res in allres{
                if res.lastmessage != ""{
                    latestfire.append(res)
                }
            }
            
            latestfire = latestfire.sorted(by: {$0.date! > $1.date!})
            
            completion(latestfire)
            
            }
    }
    
    
    func addLatest(latest:Latest)
    {
        do{
            try FirebaseReg(.Latest).document(latest.id).setData(from: latest)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func deleteLatets(latest:Latest)
    {
        FirebaseReg(.Latest).document(latest.id).delete()
    }
    
    
    
    
    
}





func startchat(user1:User,user2:User) -> String
{
    let chatroomid = chatroomIdFrom(user1Id: user1.id, user2Id: user2.id)
    
    createLatestItems(chatroomid: chatroomid, users: [user1,user2])
    return chatroomid
}

func chatroomIdFrom(user1Id:String,user2Id:String)->String{
    var chatroomid = ""
    
    let val = user1Id.compare(user2Id).rawValue
    
    chatroomid = val < 0 ? (user1Id + user2Id) : (user2Id + user1Id)
    
    return chatroomid
}

func createLatestItems(chatroomid:String,users:[User])
{
    var membersIdToCreateRecent = [users.first!.id,users.last!.id]
    var getrec = [users.first!,users.last!]
    let index = getrec.firstIndex(of: User.currentUser!)
    getrec.remove(at: index!)
    let recidgen = getrec.first
    FirebaseReg(.Latest).whereField("chatRoomId",isEqualTo: chatroomid).getDocuments { snapshot, error in
        
        guard let snapshot = snapshot else{
            return
        }
        if !snapshot.isEmpty{
            membersIdToCreateRecent = removememebr(snapshot: snapshot, memberIds: membersIdToCreateRecent)
        }
      
        for userid in membersIdToCreateRecent{
            
            let senderId = userid == User.currentId ? User.currentUser! : recidgen!
            let receiverId = userid == User.currentId ? recidgen! : User.currentUser!
           
           
            
            let recentobj = Latest(id:UUID().uuidString,chatRoomId: chatroomid,senderId: senderId.id,senderName: senderId.username,receiverId: receiverId.id,receriverName: receiverId.username,date: Date(),memeberIds: [senderId.id,receiverId.id],lastmessage: receiverId.collegeName,unreadCounter: 0,avatarLink: receiverId.profileImg,programName: receiverId.program ,collegeName: receiverId.collegeName)
            
            FirebaseLatestListener.shared.addLatest(latest: recentobj)
            
            

        }
        
        
    }
}

func removememebr(snapshot:QuerySnapshot,memberIds:[String]) -> [String]
{
    var memebridtocreate = memberIds
    
    for recentDara in snapshot.documents{
        let currentRecenet = recentDara.data() as Dictionary
        
        if let currentUserID = currentRecenet["senderId"]{
            if memebridtocreate.contains(currentUserID as! String){
                memebridtocreate.remove(at: memebridtocreate.firstIndex(of: currentUserID as! String)!)
            }
        }
       
    }
    
    return memebridtocreate
}
