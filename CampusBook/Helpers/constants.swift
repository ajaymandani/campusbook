//
//  constants.swift
//  CampusBook
//
//  Created by Ajay Mandani on 2023-01-18.
//

import Foundation

var KCURRENTUSERS = "currentUser"
var kpathref = "gs://campusbook-83f22.appspot.com"



func timeelapsed(_ date:Date) -> String
{
    var elapsed = ""
    
    let seconds = Date().timeIntervalSince(date)
    
    if( seconds < 60)
    {
        elapsed = "Just now"
    }
    else if(seconds < 60 * 60)
    {
        let min = Int(seconds/60)
        elapsed = "\(min) minute ago"
    }
    else if(seconds < 24*60*60)
    {
        let hours = Int(seconds/(60*60))
        elapsed = "\(hours) hour ago"
    }else {
        elapsed = "\(date.longdate())"
    }
    return elapsed
}

extension Date{

    func longdate() -> String{
        let dateformater = DateFormatter()
        dateformater.dateFormat = "dd MMM yyyy"
        return dateformater.string(from: self)
    }
    
    func time() -> String{
        let dateformater = DateFormatter()
        dateformater.dateFormat = "HH:mm"
        return dateformater.string(from: self)
    }
    
    
}
