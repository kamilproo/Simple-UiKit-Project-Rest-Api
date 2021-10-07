//
//  Model.swift
//  UiKitRestApiApp
//
//  Created by kamil on 07.10.2021.
//

import Foundation


struct Post: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

