//
//  LEScan.swift
//  hcitool
//
//  Created by Marco Estrella on 3/26/18.
//

import BluetoothLinux
import Bluetooth
import Foundation

/// Tests the Scanning functionality.
func LEScanTest(controller: HostController, duration: TimeInterval) {
    
    print("Scanning for \(duration) seconds...")
    
    let startDate = Date()
    let endDate = startDate + duration
    
    do { try controller.lowEnergyScan(shouldContinueScanning: { Date() < endDate },
                                   foundDevice: { print($0.address) }) }
        
    catch { print("Could not scan: \(error)") }
}
