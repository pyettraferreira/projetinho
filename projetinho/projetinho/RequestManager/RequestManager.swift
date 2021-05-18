//
//  RequestManager.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 23/04/21.
//

import Foundation

protocol Requestable {
    func request<D: Decodable>(with endpoint: Endpoint, completion: @escaping (Result<D, APIError>) -> Void)
}

struct RequestManager: Requestable {
    private let session: URLSessionable

    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    func request<D>(with endpoint: Endpoint, completion: @escaping (Result<D, APIError>) -> Void) where D : Decodable {
        guard let url = URL(string: endpoint.absoluteURL) else {
            return completion(.failure(.malformedURL))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        let task = session.dataTask(with: urlRequest) { data, _, error in
            if let requestError = error {
                completion(.failure(.other(requestError)))
            }
            
            guard let jsonData = data else {
                return completion(.failure(.malformedData))
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(D.self, from: jsonData)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.other(error)))
            }
        }
        
        task.resume()
    }
}
