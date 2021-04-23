//
//  APIError.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 23/04/21.
//

import Foundation

enum APIError: Error {
    case malformedURL
    case malformedData
    case other(Error)
}
