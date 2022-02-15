//
//  DetailsViewController.swift
//  NewsToday
//
//  Created by Dafna Cohen on 29/01/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    var article: Article?
    var action : ArticleDetailsAction!
    var repo = FavoritesRepository()
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleURL: UILabel!
    
    
    @IBOutlet weak var favButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if action == .favorites {
            favButton.setAttributedTitle(NSAttributedString(string: "Remove from favorites", attributes: [NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .caption1)]), for: .normal)
            
            favButton.addAction(UIAction(handler: {[weak self] act in
                if let article = self?.article {
                    self?.repo.removeArticleFromFavorites(article)
                    self?.navigationController?.popViewController(animated: true)
                }
            }), for: .touchUpInside)
        } else if action == .home {
            favButton.addAction(UIAction(handler: {[weak self] act in
                if let article = self?.article {
                    self?.repo.saveArticleToFavorites(article)
                }
            }), for: .touchUpInside)
        }
        
        guard let article = article else {return}
        
        article.image?.downloadImage(to: articleImage)
        articleTitle.text = article.title.replaceCharacters()
        articleAuthor.text = article.author
        articleDate.text = article.publishedAt.formatter()
        articleSource.text = "Source: \(article.source)"
        articleDescription.text = article.description.replaceCharacters()
        articleURL.isUserInteractionEnabled = true
        articleURL.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openArticleLink)))
        articleURL.text = "Read more here"
        articleURL.textColor = UIColor.systemBlue
        
    }
    
    @objc func openArticleLink() {
        guard let url = article?.url else {return}
        openURL(url)
    }
    
}
