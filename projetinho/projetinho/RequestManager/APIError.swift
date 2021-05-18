//
//  APIError.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 23/04/21.
//

import Foundation

enum APIError: LocalizedError {
    case malformedURL
    case malformedData
    case other(Error)

    var errorDescription: String? {
        switch self {
        case .malformedURL:
            return "URL mal formatada"
        case .malformedData:
            return "Informações mal formatadas"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
