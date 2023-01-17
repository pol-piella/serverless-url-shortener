// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "URLShortener",
    platforms: [.macOS(.v11)],
    products: [
        .executable(name: "URLShortener", targets: ["URLShortener"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-cloud/Compute", from: "2.8.0"),
        .package(url: "https://github.com/swift-cloud/Upstash", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "URLShortener",
            dependencies: ["Compute", "Upstash"]
        )
    ]
)
