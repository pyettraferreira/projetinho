//
//  Cell.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 29/03/21.
//

import Foundation
import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func configure(title: String) {
        label.text = title
    }
}
