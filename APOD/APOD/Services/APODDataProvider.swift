//
//  APODDataProvider.swift
//  APOD
//
//  Created by Chouhan Ravindra on 07/02/22.
//

import UIKit

public class APODDataProvider: DataProviding {
    public var isAvailable: Bool = true
    private var model: APODModel?
    private let remoteDataProvider = APODRemoteDataProvider(networkManager: NetworkManager())
    private let localDataProvider = APODLocalDataProvider()

    public func fetchAPODModel(completion: @escaping (APODModel?) -> Void) {
        if remoteDataProvider.isAvailable {
            remoteDataProvider.fetchAPODModel { [weak self] model in
                self?.model = model
                completion(model)
            }
        } else {
            localDataProvider?.fetchAPODModel(completion: { model in
                completion(model)
            })
        }
    }

    public func image(at url: URL, completion: @escaping (UIImage?) -> Void) {
        if remoteDataProvider.isAvailable {
            remoteDataProvider.image(at: url) {[weak self] image in
                completion(image)
                guard let model = self?.model, let image = image else {
                    return
                }
                self?.localDataProvider?.store(apodModel: model, image: image)
            }
        } else {
            localDataProvider?.image(at: url, completion: { image in
                completion(image)
            })
        }
    }
}
