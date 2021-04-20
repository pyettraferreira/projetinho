//
//  ViewLayoutable.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 16/04/21.
//
import UIKit

protocol ViewLayoutable {
    func buildHierarchy()
    func buildConstraints()
    func buildAdditionalSetUp()
    func buildLayout()
}

extension ViewLayoutable {
    func buildLayout() {
        buildHierarchy()
        buildConstraints()
        buildAdditionalSetUp()
    }
    
    func buildAdditionalSetUp() {}
}
