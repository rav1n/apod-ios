//
//  DataStoring.swift
//  APOD
//
//  Created by Chouhan Ravindra on 07/02/22.
//

import Foundation
import UIKit

public protocol DataStoring {
    func store(apodModel: APODModel, image: UIImage)
}
