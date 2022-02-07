//
//  APODViewModel.swift
//  APOD
//
//  Created by Chouhan Ravindra on 07/02/22.
//

import UIKit.UIImage

public class APODViewModel {
    let provider: APODDataProvider
    var title: String { return apod?.title ?? "Loading..." }
    var image: UIImage?
    var explanation: String? { return apod?.explanation }

    var viewModelUpdated: (() -> ())?

    var apod: APODModel? {
        didSet {
            guard let urlString = apod?.url,
                  let url = URL(string: urlString) else { return }
            provider.image(at: url) { [weak self] image in
                self?.image = image
                self?.viewModelUpdated?()
            }
        }
    }

    init(provider: APODDataProvider) {
        self.provider = provider
        provider.fetchAPODModel { [weak self] apod in
            guard let apod = apod else { return }
            self?.apod = apod
            self?.viewModelUpdated?()
        }
    }
}
