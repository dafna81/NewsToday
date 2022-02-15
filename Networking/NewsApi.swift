//
//  APIManager.swift
//  NewsToday
//
//  Created by Dafna Cohen on 21/01/2022.
//

import Foundation
import Combine

class NewsApi {
    private static let apiClient = ApiClient()
    private static let apiKey = "da2cb06c16589460b8fd2f2ea5833539"
    private static let baseURL = URL(string: "http://api.mediastack.com/")!
    
    enum NewsCategory {
        case health,
        general,
        business,
        entertainment,
        science,
        sports,
        technology
    }
    
}

extension NewsApi {
    private static func request<T: Decodable>(queryParams: [String:String] = [:]) -> AnyPublisher<T, Error> {
        let url = baseURL.appendingPathComponent("v1/news")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "access_key", value: apiKey)]
        let params = queryParams.map {
            URLQueryItem(name: $0, value: $1)
        }
        components?.queryItems?.append(contentsOf: params)
        let request = URLRequest(url: components!.url!)
        return apiClient.run(request)
    }
    
    public static func getNewsByCategory(newsCategory: String) -> AnyPublisher<NewsResponse, Error> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: .now)
                return request(queryParams: ["categories": newsCategory.lowercased(), "languages": "en", "countries": "us,gb,il", "limit": "100", "date": "\(todayString)"])
    }
}

