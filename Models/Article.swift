//
//  Article.swift
//  NewsToday
//
//  Created by Dafna Cohen on 19/01/2022.
//

import Foundation

struct Article : Codable {

    let author:String?
    let title:String
    let description:String
    let url:String
    let source:String
    let image:String?
    let category:String
    let language:String
    let country:String
    let publishedAt:String

}

extension Article {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        dict["author"] = self.author
        dict["title"] = self.title
        dict["description"] = self.description
        dict["url"] = self.url
        dict["source"] = self.source
        dict["image"] = self.image
        dict["category"] = self.category
        dict["language"] = self.language
        dict["country"] = self.country
        dict["publishedAt"] = self.publishedAt
        return dict
    }
    
    static func fromDict(_ dict:[String:Any]) -> Article {
        let undefined = "undefined"
        let author = dict["author"] as? String ?? undefined
        let title = dict["title"] as? String ?? undefined
        let description = dict["description"] as? String ?? undefined
        let url = dict["url"] as? String ?? undefined
        let source = dict["source"] as? String ?? undefined
        let image = dict["image"] as? String ?? undefined
        let category = dict["category"] as? String ?? undefined
        let language = dict["language"] as? String ?? undefined
        let country = dict["country"] as? String ?? undefined
        let publishedAt = dict["publishedAt"] as? String ?? undefined
        return Article(author: author, title: title, description: description, url: url, source: source, image: image, category: category, language: language, country: country, publishedAt: publishedAt)
    }
    
  
}
