//
//  ViewController.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 29/03/21.
//
import UIKit

private extension ViewController.Layout {
    enum TableView {
        static let rowHeight = UITableView.automaticDimension
        static let estimatedRowHeight: CGFloat = 100
    }
}

final class ViewController: UIViewController {
    fileprivate enum Layout { }
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = Layout.TableView.rowHeight
        tableView.estimatedRowHeight = Layout.TableView.estimatedRowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    private var api: API?
    private var contatos = [Contact]()
    
    // MARK: - Initializer
    
    init() {
        super.init(nibName: nil, bundle: nil)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = API(delegate: self)
        api?.fetch()
    }
}

// MARK: - ViewConfiguration

extension ViewController: ViewLayoutable {
    func buildHierarchy() {
        view.addSubview(tableView)
    }
    
    func buildConstraints() {
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    func buildAdditionalSetUp() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: APIDelegate {
    func onSuccess(contacts: [Contact]) {
        self.contatos = contacts
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func onError(error: String) {
        print(error)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("contatos aqui")
        print(contatos)
        let model = contatos[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Cell else {
            fatalError("Essa célula tem que retornar")
        }

        cell.configure(cellModel: model)

        return cell
    }
}
