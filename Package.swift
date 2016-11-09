import PackageDescription

let package = Package(
    name: "pizzaservice",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 0),
        .Package(url: "https://github.com/vapor/mongo-provider.git", majorVersion: 1, minor: 0)
    ]
)
