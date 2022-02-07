//
//  APODRemoteDataProvider.swift
//  APOD
//
//  Created by Chouhan Ravindra on 07/02/22.
//

import Foundation
import UIKit

/// Provides endpoint for APOD Image API
struct APODImagesEndpoint {
    private var components = URLComponents()
    private let apiKey = "YXIFSpTrr1mRdLKvrZqt9hXX2x3FPid8VD48KwxM"
    public var url: URL? { return components.url }

    public init() {
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = "/planetary/apod"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
    }
}

/// Fetches data from APOD Image API
class APODRemoteDataProvider: DataProviding {
    private let networkManager: NetworkManaging
    public var isAvailable: Bool { return true }

    public init(networkManager: NetworkManaging) {
        self.networkManager = networkManager
    }

    public func fetchAPODModel(completion: @escaping ((APODModel?) -> Void)) {
        networkManager.fetchData(from: APODImagesEndpoint().url!) { (result) in
            switch result {
            case .success(let data):
                let model = try? JSONDecoder().decode(APODModel.self, from: data)
                completion(model)
            case .failure( let error):
                print("Error : \(error)")
                completion(nil)
            }
        }
    }

    public func image(at url: URL, completion: @escaping (UIImage?) -> Void) {
        networkManager.fetchData(from: url) { (result) in
            switch result {
            case .success(let data):
                completion(UIImage(data: data))
            case .failure( _):
                completion(nil)
            }
        }
    }
}

