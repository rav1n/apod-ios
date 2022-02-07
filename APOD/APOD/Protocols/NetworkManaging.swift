//
//  NetworkManaging.swift
//  APOD
//
//  Created by Chouhan Ravindra on 07/02/22.
//

import Foundation

/// Providers interface to access remote resources
public protocol NetworkManaging {
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
