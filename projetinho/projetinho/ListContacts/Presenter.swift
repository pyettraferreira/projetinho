//
//  Presenter.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 23/04/21.
//

import Foundation

protocol Presenting {
    var view: Displaying? { get set }
    func fetch()
}

protocol Displaying: AnyObject {
    func showLoading()
    func hideLoad()
    func show(contacts: [Contact])
    func show(message: String)
}

final class Presenter: Presenting {
    weak var view: Displaying?
    private let service: Servicing
    
    init(service: Servicing = Service()) {
        self.service = service
    }
    
    func fetch() {
        view?.showLoading()
        service.fetch { [weak self] result in
            self?.view?.hideLoad()
            switch result {
            case .success(let contacts):
                self?.view?.show(contacts: contacts)
                
            case .failure(let error):
                self?.view?.show(message: error.localizedDescription)
            }
        }
    }
}
