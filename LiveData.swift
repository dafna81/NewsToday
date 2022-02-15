//
//  LiveData.swift
//  NewsToday
//
//  Created by Dafna Cohen on 20/01/2022.
//

import Foundation
import UIKit

class LiveData<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func observe(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}


