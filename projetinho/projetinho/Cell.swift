//
//  Cell.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 29/03/21.
//

import Foundation
import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    func configure(cellModel: Contact) {
        nameLabel.text = cellModel.name
        photoImageView.image = load(url: cellModel.photoURL)
    }
    
    func load(url: String) -> UIImage {
        let imageURL = URL(string: url)!
        let imageData = try! Data(contentsOf: imageURL)
        return UIImage(data: imageData)!
    }
}
