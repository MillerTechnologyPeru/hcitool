// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "hcitool",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(
            name: "hcitool",
            targets: ["hcitool"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/PureSwift/BluetoothLinux.git",
            branch: "master"
        ),
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            .upToNextMinor(from: "1.1.0")
        ),
    ],
    targets: [
        .executableTarget(
            name: "hcitool",
            dependencies: [
                "BluetoothLinux",
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                )
            ]
        )
    ]
)
