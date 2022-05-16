//
//  iBeacon.swift
//  hcitool
//
//  Created by Alsey Coleman Miller on 3/27/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Foundation
import ArgumentParser
import Bluetooth
import BluetoothGAP
import BluetoothHCI
import BluetoothLinux

/// Advertise as Apple iBeacon command
struct Beacon: DeviceCommand {
    
    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "ibeacon",
            abstract: "Advertise as Apple iBeacon"
        )
    }
    
    @Option(name: .customShort("i"), help: "HCI device")
    var device: String?
    
    @Option(help: "Beacon UUID")
    var uuid: UUID

    @Option(help: "Major")
    var major: UInt16

    @Option(help: "Minor")
    var minor: UInt16

    @Option(help: "RSSI")
    var rssi: Int8

    @Option(help: "Advertising Interval")
    var interval: AdvertisingInterval = .default
    
    func run(_ hostController: HostController) async throws {
        // set advertisment data
        let beacon = AppleBeacon(
            uuid: uuid, 
            major: major, 
            minor: minor, 
            rssi: rssi
        )
        try await hostController.iBeacon(beacon: beacon, interval: interval)
    }
}