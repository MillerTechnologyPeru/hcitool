// swift-tools-version:3.0

import PackageDescription

let package = Package(
    name: "hcitool",
    targets: [
        Target(
            name: "hcitool",
            dependencies: [])
    ],
    dependencies: [
        .Package(url: "https://github.com/PureSwift/BluetoothLinux.git", majorVersion: 3),
        .Package(url: "https://github.com/colemancda/Rainbow.git", majorVersion: 3)
    ]
)
