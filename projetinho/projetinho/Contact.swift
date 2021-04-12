//
//  CellModel.swift
//  projetinho
//
//  Created by Pyettra Ferreira on 30/03/21.
//

/*
 Json Contract
[
  {
    "id": 1,
    "name": "Shakira",
    "photoURL": "https://api.adorable.io/avatars/285/a1.png"
  }
]
*/

struct Contact: Decodable {
    let id: Int
    let name: String
    let photoURL: String
}
