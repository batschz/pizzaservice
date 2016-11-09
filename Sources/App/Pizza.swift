//
//  Pizza.swift
//  pizzaservice
//
//  Created by Werner Huber on 09/11/2016.
//
//

import Vapor
import Fluent
import Foundation

final class Pizza: Model {
    var id: Node?
    var name: String
    var price: Float
    
    init(name: String, price: Float) {
        self.id = UUID().uuidString.makeNode()
        self.name = name
        self.price = price
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        price = try node.extract("price")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "price": price
            ])
    }
}

extension Pizza: Preparation {
    static func prepare(_ database: Database) throws {
    }
    
    static func revert(_ database: Database) throws {
    }
}
