// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ALExt",
    platforms: [.iOS(.v9)],
    products: [ .library(name: "ALExt", targets: ["ALExt"]) ],
    dependencies: [],
    targets: [ .target(name: "ALExt", dependencies: []) ]
)
