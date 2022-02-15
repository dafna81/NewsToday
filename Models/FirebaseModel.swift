//
//  FirebaseModel.swift
//  NewsToday
//
//  Created by Dafna Cohen on 19/01/2022.
//

import Foundation

protocol FirebaseModel {
    // dictionary <String, Any>
    var dict: [String : Any] {get} // computed property (GET)
    
    // init(dict)
    init?(dict: [String : Any]) // failable init -> if the json is invalid
    
    //return nil
}

extension FirebaseModel {
    // static in order to be a shared variable to all instances
    static var formatter: ISO8601DateFormatter {
        // formatter takes a date -> String
        // formatter takes a String -> date
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        return formatter
    }
}
