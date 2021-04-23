//
//  RequestManager.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 23/04/21.
//

import Foundation

protocol Requestable {
    func request<D: Decodable>(with endpoint: Endpoint, completion: (Result<D, APIError>) -> Void)
}

final class RequestManager: Requestable {
    func request<D>(with endpoint: Endpoint, completion: (Result<D, APIError>) -> Void) where D : Decodable {
        
    }
    
}
