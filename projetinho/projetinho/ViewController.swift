//
//  ViewController.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 29/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let models: [Model] = [
        Model(title: "Vibrant Blue", color: UIColor(red: 0.00, green: 0.00, blue: 1.00, alpha: 1.00)),
        Model(title: "Vibrant Pink", color: UIColor(red: 1.00, green: 0.00, blue: 1.00, alpha: 1.00)),
        Model(title: "Vibrant Yellow", color: UIColor(red: 1.00, green: 1.00, blue: 0.00, alpha: 1.00)),
        Model(title: "Vibrant Green", color: UIColor(red: 0.00, green: 1.00, blue: 0.00, alpha: 1.00)),
        Model(title: "Vibrant Purple", color: UIColor(red: 0.50, green: 0.00, blue: 1.00, alpha: 1.00)),
        Model(title: "Pastel Blue", color: UIColor(red: 0.40, green: 0.70, blue: 1.00, alpha: 1.00)),
        Model(title: "Pastel Pink", color: UIColor(red: 1.00, green: 0.60, blue: 1.00, alpha: 1.00)),
        Model(title: "Pastel Yellow", color: UIColor(red: 1.00, green: 1.00, blue: 0.60, alpha: 1.00)),
        Model(title: "Pastel Green", color: UIColor(red: 0.60, green: 1.00, blue: 0.60, alpha: 1.00)),
        Model(title: "Pastel Purple", color: UIColor(red: 0.80, green: 0.60, blue: 1.00, alpha: 1.00))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? Cell else {
            fatalError("Essa célula tem que retornar")
        }
        
        cell.configure(title: model.title)
        cell.backgroundColor = model.color
        
        return cell
    }
}
