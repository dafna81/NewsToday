//
//  AppAuth.swift
//  NewsToday
//
//  Created by Dafna Cohen on 19/01/2022.
//

import Foundation
import FirebaseAuth

class AppAuth {
    static let shared = AppAuth()
    
    var currentUser: User? {
        Auth.auth().currentUser
    }
    
    private init() {}
    
    func signIn(email: String, password: String, callback: FireAuthCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: callback)
    }
    
    
    
    func signOut() {
        try? Auth.auth().signOut()
        Router.shared.determineRootViewController()
    }
}

typealias FireAuthCallback = ((AuthDataResult?, Error?) -> Void)?
