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
    
    func run() throws {
        let list = try HostController.deviceList()
        for device in list {
            let info = try HostController.deviceInformation(for: device.id)
            print(info.id)
            print(info.name)
            print(info.address)
        }
    }
}
