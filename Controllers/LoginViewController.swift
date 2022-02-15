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

    
    @IBOutlet weak var googleSinInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleSinInButton.isUserInteractionEnabled = true
        googleSinInButton.addAction(UIAction(handler: {[weak self] act in
            self?.signIn()
        }), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
   
    
    func signIn() {
        let config = AppDelegate.signInConfig
        print("Signing in started")
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in

          if let error = error {
            print(error)
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
              print("??")
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { result, error in
                Router.shared.determineRootViewController()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
