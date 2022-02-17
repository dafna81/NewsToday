//
//  LoginViewController.swift
//  NewsToday
//
//  Created by Dafna Cohen on 19/01/2022.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var anonymousSignInButton: UIButton!
    
    @IBOutlet weak var googleSinInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        anonymousSignInButton.addTarget(self, action: #selector(handleSignInAnonymously),
                                        for: .touchUpInside)
        googleSinInButton.isUserInteractionEnabled = true
        googleSinInButton.addAction(UIAction(handler: {[weak self] act in
            self?.signIn()
        }), for: .touchUpInside)
    }
    
    @objc func handleSignInAnonymously() {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            }
            Router.shared.determineRootViewController()
        }
    }
    
    func signIn() {
        let config = AppDelegate.signInConfig
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            if let error = error {
                print(error)
                return
            }
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { result, error in
                Router.shared.determineRootViewController()
            }
        }
    }
    
}
