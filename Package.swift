// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "GraphQLer",
    products: [
        .library(name: "GraphQLer", targets: ["GraphQLer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.2.0"),
    ],
    targets: [
        .target(
            name: "GraphQLer",
            dependencies: []),
        .testTarget(
            name: "GraphQLTests",
            dependencies: ["GraphQLer"]),
    ]
)
