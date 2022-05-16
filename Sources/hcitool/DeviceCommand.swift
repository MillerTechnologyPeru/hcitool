//
//  DeviceCommand.swift
//  
//
//  Created by Alsey Coleman Miller on 5/14/22.
//

import Foundation
import ArgumentParser
import Bluetooth
import BluetoothHCI
import BluetoothLinux

protocol DeviceCommand: AsyncParsableCommand {
    
    var device: String? { get }
    
    func run(_ hostController: HostController) async throws
}

extension DeviceCommand {
    
    func run() async throws {
        if let name = self.device {
            guard let controller = await HostController.controllers.first(where: { $0.name == name }) else {
                throw CommandError.invalidDevice(name)
            }
            try await run(controller)
        } else {
            guard let controller = await HostController.default else {
                throw CommandError.invalidDevice("hci0")
            }
            try await run(controller)
        }
    }
}
