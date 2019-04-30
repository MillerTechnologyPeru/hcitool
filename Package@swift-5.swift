// swift-tools-version:5.0
import PackageDescription

#if os(macOS)
let package = Package(
    name: "hcitool",
    products: [
        .executable(name: "hcitool", targets: ["hcitool"])
    ],
    dependencies: [
        .package(url: "https://github.com/PureSwift/BluetoothDarwin.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "hcitool",
            dependencies: [
                "BluetoothDarwin"
            ]
        )
    ]
)
#elseif os(Linux)
let package = Package(
    name: "hcitool",
    products: [
        .executable(name: "hcitool", targets: ["hcitool"])
    ],
    dependencies: [
        .package(url: "https://github.com/PureSwift/BluetoothLinux.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "hcitool",
            dependencies: [
                "BluetoothLinux"
            ]
        )
    ]
)
#endif
