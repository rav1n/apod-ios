//
//  ImageProviding.swift
//  APOD
//
//  Created by Chouhan Ravindra on 07/02/22.
//

import UIKit

/// Providers interface for accessing images over remote API
public protocol ImageProviding {
    func fetchAPODModel(completion: @escaping (APODModel?) -> Void)
    func image(at url: URL, completion: @escaping (UIImage?) -> Void)
}
