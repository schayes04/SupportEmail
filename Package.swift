// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SupportEmail",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "SupportEmail", targets: ["SupportEmail"])
    ],
    targets: [
        .target(name: "SupportEmail")
    ],
    swiftLanguageVersions: [.v5]
)
