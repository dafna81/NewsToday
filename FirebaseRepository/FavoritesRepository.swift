//
//  FavoritesRepository.swift
//  NewsToday
//
//  Created by Dafna Cohen on 20/01/2022.
//

import Foundation
import FirebaseDatabase
import Combine

class FavoritesRepository {
    
    func getFavoritesRef() -> DatabaseReference {
        if let user = AppAuth.shared.currentUser {
        return RealtimeDB.root.child("users")
            .child(user.uid)
            .child("favorites")
        }
        return DatabaseReference()
    }
    
    let subject = PassthroughSubject<[Article],Never>()

    var observerHandle: UInt = 0
    func fetchFavorites() {
        self.observerHandle = getFavoritesRef().observe(.value) { snapshot in
            if let children = snapshot.children.allObjects as? [DataSnapshot] {
                let favoritesList = children.map { snap -> Article in
                    let dict = snap.value as! [String:Any]
                    return Article.fromDict(dict)
                }
                self.subject.send(favoritesList)
            }
        }
    }
    
    deinit {
        getFavoritesRef().removeObserver(withHandle: observerHandle)
    }

    func saveArticleToFavorites(_ article:Article) {
        RealtimeDB.root.child("users")
            .child(AppAuth.shared.currentUser!.uid)
            .child("favorites")
        getFavoritesRef().childByAutoId().setValue(article.toDict())
    }
    
    func removeArticleFromFavorites(_ article:Article) {
        getFavoritesRef().observeSingleEvent(of: .value) { snapshot in
            if let children = snapshot.children.allObjects as? [DataSnapshot] {
                // finds the article by title
                let match = children.first { dataSnapshot in
                    let dict = dataSnapshot.value as! [String:Any]
                    return dict["title"] as! String == article.title
                }
                match?.ref.removeValue() // removes the found article
            }
        }
    }
}
