//
//  Endpoint.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 23/04/21.
//
import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var absoluteURL: String { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    var baseURL: URL {
        guard let baseURL = URL(string: "https://run.mocky.io/v3/") else {
            fatalError("É preciso definir a URL")
        }
        return baseURL
    }
    
    var absoluteURL: String {
        "\(baseURL)\(path)"
    }
    
    var method: HTTPMethod {
        .get
    }
}
