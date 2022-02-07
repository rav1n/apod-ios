//
//  APODViewModel.swift
//  APOD
//
//  Created by Chouhan Ravindra on 07/02/22.
//

import UIKit.UIImage

public class APODViewModel {
    let provider: DataProviding
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    var title: String { return apod?.title ?? "Loading..." }
    var image: UIImage?
    var explanation: String? { return apod?.explanation ?? "Loading..." }

    var viewModelUpdated: (() -> ())?
    var isShowingOldModel: Bool {
        guard let model = apod else { return false }
        return isAPODModelOld(model)
    }

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

    init(provider: DataProviding) {
        self.provider = provider
        provider.fetchAPODModel { [weak self] apod in
            guard let apod = apod else { return }
            self?.apod = apod
            self?.viewModelUpdated?()
        }
    }

    private func isAPODModelOld(_ model: APODModel) -> Bool {
        let dateString = dateFormatter.string(from: Date.now)
        let isModelOld = apod?.date != dateString
        return isModelOld
    }
}
