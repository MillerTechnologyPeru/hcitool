//
//  LEScan.swift
//  hcitool
//
//  Created by Marco Estrella on 3/26/18.
//

import Foundation
import ArgumentParser
import Bluetooth
import BluetoothHCI
import BluetoothLinux

/// Start LE scan command
struct LEScan: DeviceCommand {
    
    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "lescan",
            abstract: "Start LE scan"
        )
    }
    
    @Option(name: .customShort("i"), help: "HCI device")
    var device: String?
    
    @Option(help: "Scan duration")
    var duration: UInt?

    @Option(help: "Filter duplicates")
    var filterDuplicates = true
    
    func run(_ hostController: HostController) async throws {
        let parameters = HCILESetScanParameters(/*
            type: HCILESetScanParameters.ScanType, 
            interval: HCILESetScanParameters.TimeInterval, 
            window: HCILESetScanParameters.TimeInterval, 
            addressType: LowEnergyAddressType,
            filterPolicy: HCILESetScanParameters.FilterPolicy*/
        )
        // start scan
        let stream = try await hostController.lowEnergyScan(filterDuplicates: filterDuplicates, parameters: parameters)
        print("LE Scan...")
        if let duration = self.duration {
            // stop in x seconds
            Task {
                try await Task.sleep(nanoseconds: 1_000_000_000 * UInt64(duration))
                stream.stop()
            }
        }
        // print results
        for try await scanData in stream {
            print(scanData.address, scanData.addressType, scanData.event, scanData.rssi?.description ?? "", scanData.responseData)
        }
    }
}
