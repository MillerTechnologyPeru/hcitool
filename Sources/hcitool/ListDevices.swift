//
//  ListDevices.swift
//  
//
//  Created by Alsey Coleman Miller on 5/14/22.
//

import Foundation
import ArgumentParser
import Bluetooth
import BluetoothHCI
import BluetoothLinux

struct ListDevices: AsyncParsableCommand {
    
    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "dev",
            abstract: "Display local devices"
        )
    }
    
    @Option(help: "HCI device")
    var device: String
    
    func run() async throws {
        let controllers = await Self.devices
        print("Devices:")
        for (name, controller) in controllers {
            let address = try await controller.readDeviceAddress()
            print("     " + name + " " + address.rawValue)
        }
    }
}
