//
//  FavoritesViewController.swift
//  NewsToday
//
//  Created by Dafna Cohen on 29/01/2022.
//

import UIKit
import Combine

class FavoritesViewController: ArticleViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let repo = FavoritesRepository()
    
    var tasks = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.action = .favorites
        
        self.tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        repo.subject.sink {[weak self] news in
          self?.news = news
          self?.tableView.reloadData()
        }.store(in: &tasks)

        repo.fetchFavorites()
        

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = self.news[indexPath.row]
        performSegue(withIdentifier: "favoritesToDetails", sender: article)
    }

   
    
}

