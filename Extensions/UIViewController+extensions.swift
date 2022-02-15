//
//  UIViewController+extensions.swift
//  NewsToday
//
//  Created by Dafna Cohen on 19/01/2022.
//

import Foundation
import PKHUD
import FirebaseAuth
import UIKit

extension UIViewController  {
    func openURL(_ urlString:String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}
protocol ShowHUD {
    
}

extension ShowHUD {
    func showProgress(title: String, subtitle: String? = nil) {
        HUD.show(.labeledProgress(title: title, subtitle: subtitle))
    }
    
    func showError(title: String, subtitle: String? = nil) {
        HUD.flash(.labeledError(title: title, subtitle: subtitle), delay: 2)
    }
    
    func showLabel(title: String) {
        HUD.flash(.label(title), delay: 1)
    }
    
    func showSuccess(title: String, subtitle: String? = nil) {
        HUD.flash(.labeledSuccess(title: title, subtitle: subtitle), delay: 2)
    }
}

extension UIViewController: ShowHUD {
    
}

protocol UserValidation: ShowHUD {}

extension UserValidation {
    func callbackSignIn(_ result: AuthDataResult?, _ err: Error?) {
        if let err = err {
            showError(title: "Error", subtitle: "\(err.localizedDescription)")
            return
        }
    }
}

extension LoginViewController: UserValidation {
    
}

extension String { // example: "https://dog.png".downloadImage(imageView)
    func downloadImage(to imageView:UIImageView) {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let url = URL(string: self) else {return}
            guard let data = try? Data(contentsOf: url) else {return}
            guard let image = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
    
    func formatter() -> String {
        // formatter takes a date -> String
        // formatter takes a String -> date
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: self) else { return "" }
        let dateString = date.formatted(date: .long, time: .shortened)

        return dateString
    }
    
    func toDate() -> Date {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: self) else { return Date() }
        return date
    }
    
    func replaceCharacters() -> String {
        return self.replacingOccurrences(of: "&#8217;", with: "'").replacingOccurrences(of: "&#8230;", with: "...").replacingOccurrences(of: "&#8212;", with: "-").replacingOccurrences(of: "&#39;", with: "'").replacingOccurrences(of: "&#8220;", with: "\"").replacingOccurrences(of: "&#8221;", with: "\"").replacingOccurrences(of: "&#32;", with: " ").replacingOccurrences(of: "&nbsp;", with: " ")
    }
}
