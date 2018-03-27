//
//  LEScan.swift
//  hcitool
//
//  Created by Marco Estrella on 3/26/18.
//

#if os(Linux)
import BluetoothLinux
#elseif os(macOS)
import BluetoothDarwin
import IOBluetooth
#endif

import Bluetooth
import Foundation

/// Tests the Scanning functionality.
func LEScanTest(controller: HostController, duration: TimeInterval) {
    
    print("Scanning for \(duration) seconds...")
    
    let startDate = Date()
    let endDate = startDate + duration
    
    do { try controller.lowEnergyScan(shouldContinue: { Date() < endDate },
                                   foundDevice: { print($0.address) }) }
        
    catch { print("Could not scan: \(error)") }
}
