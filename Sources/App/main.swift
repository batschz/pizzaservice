import Vapor
import VaporMongo

let mongo = try VaporMongo.Provider(database: "heroku_8p41vt0m", user: "pizza", password: "salami", host: "ds147487.mlab.com", port: 47487)

let drop = Droplet(preparations: [Pizza.self], initializedProviders: [mongo])

drop.resource("pizza", PizzaController())

drop.run()
