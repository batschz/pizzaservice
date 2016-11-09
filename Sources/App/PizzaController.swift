//
//  PizzaController.swift
//  pizzaservice
//
//  Created by Werner Huber on 09/11/2016.
//
//

import Vapor
import HTTP

final class PizzaController: ResourceRepresentable {
    func index(request: Request) throws -> ResponseRepresentable {
        return try Pizza.all().makeNode().converted(to: JSON.self)
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        var pizza = try request.post()
        try pizza.save()
        return pizza
    }
    
    func show(request: Request, pizza: Pizza) throws -> ResponseRepresentable {
        return pizza
    }
    
    func delete(request: Request, pizza: Pizza) throws -> ResponseRepresentable {
        try pizza.delete()
        return JSON([:])
    }
    
    func clear(request: Request) throws -> ResponseRepresentable {
        try Pizza.query().delete()
        return JSON([])
    }
    
    func update(request: Request, pizza: Pizza) throws -> ResponseRepresentable {
        let new = try request.post()
        var pizza = pizza
        pizza.name = new.name
        pizza.price = new.price
        try pizza.save()
        return pizza
    }
    
    func replace(request: Request, pizza: Pizza) throws -> ResponseRepresentable {
        try pizza.delete()
        return try create(request: request)
    }
    
    func makeResource() -> Resource<Pizza> {
        return Resource(
            index: index,
            store: create,
            show: show,
            replace: replace,
            modify: update,
            destroy: delete,
            clear: clear
        )
    }
}

extension Request {
    func post() throws -> Pizza {
        guard let json = json else { throw Abort.badRequest }
        return try Pizza(node: json)
    }
}

