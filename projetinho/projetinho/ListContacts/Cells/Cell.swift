//
//  Cell.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 29/03/21.
//

import Foundation
import UIKit

private extension Cell.Layout {
    enum Size {
        static let imageSize = CGSize(width: 60, height: 60)
    }
}

final class Cell: UITableViewCell {
    fileprivate enum Layout { }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var photoImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cellModel: Contact) {
        nameLabel.text = cellModel.name
        load(url: cellModel.photoURL) { [weak self] image in
            self?.photoImageView.image = image
        }
    }
    
    func load(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: url) else { completion(nil); return }
        
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: imageURL)
                DispatchQueue.main.async {
                    completion(UIImage(data: imageData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}

extension Cell: ViewLayoutable {
    func buildHierarchy() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(photoImageView)
    }
    
    func buildConstraints() {
        
        let photoImageConstraints = [
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            photoImageView.widthAnchor.constraint(equalToConstant: Layout.Size.imageSize.width),
            photoImageView.heightAnchor.constraint(equalToConstant: Layout.Size.imageSize.height)
        ]
        
        NSLayoutConstraint.activate(photoImageConstraints)
        
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(nameLabelConstraints)
    }
    
    func buildAdditionalSetUp() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
}
