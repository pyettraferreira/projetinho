//
//  Service.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 23/04/21.
//
import Foundation
protocol Servicing {
    func fetch(completion: @escaping (Result<[Contact], APIError>) -> Void)
}

struct Service: Servicing {
    let requestManager: Requestable
    
    init(requestManager: Requestable = RequestManager()) {
        self.requestManager = requestManager
    }
    
    func fetch(completion: @escaping (Result<[Contact], APIError>) -> Void) {
        let endpoint = ListContactsEndpoints.fetch
    
        requestManager.request(with: endpoint) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
