//
//  APODModel.swift
//  APOD
//
//  Created by Chouhan Ravindra on 07/02/22.
//

import Foundation

public struct APODModel: Codable {
    public let title: String
    public let url: String?
    public let explanation: String?
}
