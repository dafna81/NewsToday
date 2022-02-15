//
//  NewsTableViewController.swift
//  NewsToday
//
//  Created by Dafna Cohen on 19/01/2022.
//

import UIKit
import Combine

class NewsTableViewController: ArticleViewController {
    
    var category: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate func reloadNews() {
        self.news = self.allNews
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.action = .home

        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
        
        if let category = category {
            NewsApi.getNewsByCategory(newsCategory: category).sink { completion in
                switch completion {
                case .finished:
                    self.reloadNews()
                case .failure(let err):
                    print(err)
                }
            } receiveValue: { [weak self] response in
                self?.allNews = response.data
                self?.tableView.reloadData()
            }.store(in: &subscriptions)
            
        } else {
            NewsApi.getNewsByCategory(newsCategory: "").sink { completion in
                switch completion {
                case .finished:
                    self.reloadNews()
                case .failure(let err):
                    print(err)
                }
            } receiveValue: { [weak self] response in
                self?.allNews = response.data
                print("allNews: \(response.data)")
                self?.tableView.reloadData()
            }.store(in: &subscriptions)
            
        }
        definesPresentationContext = true
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        super.updateSearchResults(for: searchController)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = self.news[indexPath.row]
        performSegue(withIdentifier: "newsToDetails", sender: article)
    }

}
