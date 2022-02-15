//
//  ApiClient.swift
//  NewsToday
//
//  Created by Dafna Cohen on 25/01/2022.
//

import Foundation
import Combine

struct ApiClient {
    enum ApiError: Error {
        case unknown
        case notHTTP
        case apiError(reason: String)
        case statusError(status: Int)
    }
}

extension ApiClient {
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> T in
                guard let res = result.response as? HTTPURLResponse else {
                    throw ApiError.notHTTP
                }
                let statusCode = res.statusCode
                guard (200..<300) ~= statusCode else {
                    throw ApiError.statusError(status: statusCode)
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(T.self, from: result.data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
