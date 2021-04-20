//
//  API.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 09/04/21.
//

import Foundation

let url = URL(string: "https://run.mocky.io/v3/1d9c3bbe-eb63-4d09-980a-989ad740a9ac")!

protocol APIDelegate: AnyObject {
    func onSuccess(contacts: [Contact])
    func onError(error: String)
}

class API {
    private weak var delegate: APIDelegate?
    
    init(delegate: APIDelegate) {
        self.delegate = delegate
    }
    
    func fetch(completion: @escaping (Result<[Contact]>, String) -> Void) {
        
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                self.delegate?.onError(error: error.localizedDescription)
                return
            }
            guard let jsonData = data else {
                self.delegate?.onError(error: "Data vazia")
                return
            }
            do {
                let decoder = JSONDecoder()
                let contacts = try decoder.decode([Contact].self, from: jsonData)
                self.delegate?.onSuccess(contacts: contacts)
            } catch {
                self.delegate?.onError(error: error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
