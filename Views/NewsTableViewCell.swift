//
//  NewsTableViewCell.swift
//  NewsToday
//
//  Created by Dafna Cohen on 19/01/2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    
    func populate(article: Article) {
        self.articleImage.layer.borderColor = UIColor.black.cgColor
        self.articleImage.layer.borderWidth = 0.5
        self.articleImage.layer.cornerRadius = 16
        self.articleImage.contentMode = .scaleAspectFill
        self.articleImage.image = nil
        self.articleTitle.text = article.title
        article.image?.downloadImage(to: self.articleImage)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 16
    }
    
}
