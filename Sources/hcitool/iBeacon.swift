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
    
    @Option(help: "The iBeacon UUID to advertise.")
    var uuid: UUID
    
    @Option(help: "The value identifying a group of beacons.")
    var major: UInt16

    @Option(help: "The value identifying a specific beacon within a group.")
    var minor: UInt16

    @Option(help: "The received signal strength indicator (RSSI) value (measured in decibels) for the device.")
    var rssi: Int8
    
    @Option(help: "The time between the start of two consecutive advertising events.")
    var interval: AdvertisingInterval = .default
    
    func run(_ hostController: HostController) async throws {
        // set advertisment data
        let beacon = AppleBeacon(
            uuid: uuid, 
            major: major, 
            minor: minor, 
            rssi: rssi
        )
        try await hostController.iBeacon(beacon, interval: interval)
    }
}
