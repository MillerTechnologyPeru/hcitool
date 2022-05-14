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

extension AsyncParsableCommand {
    
    static var devices: [String: HostController] {
        get async {
            let controllers = await HostController.controllers
            var devices = [String: HostController]()
            devices.reserveCapacity(controllers.count)
            for controller in controllers {
                let key = "hci" + controller.id.rawValue.description
                devices[key] = controller
            }
            return devices
        }
    }
}

extension DeviceCommand {
    
    func run() async throws {
        let key = self.device ?? "hci0"
        guard let controller = await Self.devices[key] else {
            throw CommandError.invalidDevice(key)
        }
        try await run(controller)
    }
}
