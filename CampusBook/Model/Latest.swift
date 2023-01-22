//
//  Latest.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-21.
//

import Foundation
import Foundation
import FirebaseFirestoreSwift

struct Latest:Codable{
    
    var id = ""
    var chatRoomId = ""
    var senderId = ""
    var senderName = ""
    var receiverId = ""
    var receriverName = ""
    @ServerTimestamp var date = Date()
    var memeberIds = [""]
    var lastmessage = ""
    var unreadCounter = 0
    var avatarLink = ""
    var programName = ""
    var collegeName = ""
}
