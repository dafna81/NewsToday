//
//  Router.swift
//  NewsToday
//
//  Created by Dafna Cohen on 19/01/2022.
//

import UIKit
import FirebaseAuth

class Router {
    // props:
    var isUserLoggedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    weak var window: UIWindow? {
        didSet {
            // when the window is set
            determineRootViewController()
        }
    }
    
    // singleton:
    static let shared = Router()
    
    private init(){}
    
    func determineRootViewController() {
        
        guard Thread.current.isMainThread else {
            DispatchQueue.main.async {
                [weak self] in
                self?.determineRootViewController()
            }
            return
        }
        
        let fileName = isUserLoggedIn ? "Main" : "Login"
        let sb = UIStoryboard(name: fileName, bundle: .main)
                // root view controller of the storyboard:
        let vc = sb.instantiateInitialViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

