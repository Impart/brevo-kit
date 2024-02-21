// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "brevo-kit",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "BrevoKit", targets: ["BrevoKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.20.1"),
    ],
    targets: [
        .target(name: "BrevoKit", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
        ]),
        .testTarget(name: "BrevoKitTests", dependencies: [
            .target(name: "BrevoKit"),
        ])
    ]
)
