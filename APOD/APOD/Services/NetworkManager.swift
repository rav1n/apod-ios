//
//  NetworkManager.swift
//  APOD
//
//  Created by Chouhan Ravindra on 07/02/22.
//

import Foundation

/// Responsible for fetching remote resources
public class NetworkManager: NetworkManaging {
    private let session: URLSession
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    public func fetchData(from url: URL,
                          completion: @escaping (Result<Data, Error>) -> Void) {

        let task = session.dataTask(with: URLRequest(url: url))
        { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("error.localizedDescription")
            } else if (response as? HTTPURLResponse)?.statusCode == 200, let data = data {
                completion(.success(data))
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print(NetworkError.failedWithStatusCode(statusCode))
                completion(.failure(NetworkError.failedWithStatusCode(statusCode)))
            }
        }
        task.resume()
    }
}

public enum NetworkError: Error, CustomStringConvertible {
    case internetUnavailable
    case failedWithStatusCode(_ code: Int)

    public var description: String {
        switch self {
        case .internetUnavailable: return "Internet Unavailable"
        case .failedWithStatusCode(let code): return "Failed with HTTP Status Code : \(code)"
        }
    }
}
