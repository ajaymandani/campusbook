//
//  FirebaseRef.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-18.
//

import Foundation
import FirebaseFirestore

enum CollectionType:String{
    case Users
    case Latest
    case Message
}

func FirebaseReg(_ collectionType:CollectionType)->CollectionReference{
    return Firestore.firestore().collection(collectionType.rawValue)
}
