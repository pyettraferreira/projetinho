//
//  API.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 09/04/21.
//

import Foundation

class API: Servicing {
    func fetch(completion: @escaping (Result<[Contact], APIError>) -> Void) {
        guard let url = URL(string: url) else {
            return completion(.failure(.malformedURL))
        }
        
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: urlRequest) { data, _, error in
            guard let jsonData = data else {
                return completion(.failure(.malformedData))
            }
            do {
                let decoder = JSONDecoder()
                let contacts = try decoder.decode([Contact].self, from: jsonData)
                completion(.success(contacts))
            } catch {
                completion(.failure(.other(error)))
            }
        }
        task.resume()
    }
}
