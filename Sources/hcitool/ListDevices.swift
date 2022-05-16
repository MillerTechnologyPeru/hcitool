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
            print("\(info.name):" + "   " + "Type: \(info.type)" + "  " + "Bus: \(info.busType)")
            print("        " + "Address: \(info.address)")
            var flags = [String]()
            if info.flags.contains(.up) == false {
                flags.append("DOWN")
            }
            for flag in HCIDeviceFlag.allCases {
                guard info.flags.contains(flag) else {
                    continue
                }
                flags.append("\(flag) ".uppercased())
            }
            print("        " + flags.reduce("", { $0 + $1 }))
        }
    }
}
