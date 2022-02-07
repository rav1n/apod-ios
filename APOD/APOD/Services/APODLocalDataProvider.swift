//
//  APODLocalDataProvider.swift
//  APOD
//
//  Created by Chouhan Ravindra on 07/02/22.
//

import UIKit

class APODLocalDataProvider: DataStoring {
    let imagePath: URL
    struct Keys {
        static let ImageName = "apod.jpg"
        static let Data = "apod.data"
    }

    init?() {
        guard let documentsDirectory =
                try? FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false) else { return nil}
        imagePath = documentsDirectory.appendingPathComponent(Keys.ImageName)
    }

    public func store(apodModel: APODModel, image: UIImage) {
        let modelJSON = try? JSONEncoder().encode(apodModel)
        UserDefaults.standard.set(modelJSON, forKey: Keys.Data)

        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            try? image.jpegData(compressionQuality: 1)?.write(to: strongSelf.imagePath)
        }
    }
}

extension APODLocalDataProvider: DataProviding {
    public var isAvailable: Bool { return true }
    public func fetchAPODModel(completion: @escaping ((APODModel?) -> Void)) {
        guard let apodData = UserDefaults.standard.value(forKey: Keys.Data) as? Data else { return }
        let model = try? JSONDecoder().decode(APODModel.self, from: apodData)
        completion(model)
    }

    public func image(at url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self,
            let data = try? Data(contentsOf: strongSelf.imagePath) else { return }
            let image = UIImage(data: data)
            completion(image)
        }
    }
}
