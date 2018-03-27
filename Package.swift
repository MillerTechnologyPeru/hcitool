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
        .Package(url: "https://github.com/MillerTechnologyPeru/Rainbow.git", majorVersion: 3)
    ]
)

#if os(macOS)
let dependency: Package.Dependency = .Package(url: "https://github.com/PureSwift/BluetoothDarwin.git", majorVersion: 1)
package.dependencies.append(dependency)
#elseif os(Linux)
let dependency: Package.Dependency = .Package(url: "https://github.com/PureSwift/BluetoothLinux.git", majorVersion: 3)
package.dependencies.append(dependency)
#endif
