//
//  ArticleViewController.swift
//  NewsToday
//
//  Created by Dafna Cohen on 19/01/2022.
//

import UIKit
import Combine
class ArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var searchController: UISearchController!
    
    
    var subscriptions: Set<AnyCancellable> = []
    
    var allNews = [Article]() //  holds all the news
    var news: [Article]! // used for tableview - and search
    
    var action: ArticleDetailsAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        news = allNews
        
        
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        let article = news[indexPath.row]
        
        cell.populate(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = news[indexPath.row]
        performSegue(withIdentifier: "newsToDetails", sender: article)
    }
    
    // MARK: - Search Bar
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            news = searchText.isEmpty ? allNews : allNews.filter({ article in
                article.description.lowercased().contains(searchText.lowercased()) || article.title.lowercased().contains(searchText.lowercased())
            })
        }

    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? DetailsViewController else {return}
        let article = sender as? Article
        dest.action = action
        dest.article = article
    }
    
    
}

