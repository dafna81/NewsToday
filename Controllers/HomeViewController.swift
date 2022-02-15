//
//  HomeViewController.swift
//  NewsToday
//
//  Created by Dafna Cohen on 19/01/2022.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func selectCategory(_ sender: UIButton) {
        guard let label = sender.titleLabel else {return}
        performSegue(withIdentifier: "categorySegue", sender: label.text!)
    }
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let dest = segue.destination as? NewsTableViewController,
         let category = sender as? String
         else {return}
         dest.category = category
     }
     
    @IBAction func logOut(_ sender: UIButton) {
        AppAuth.shared.signOut()
    }
}
