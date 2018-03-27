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

public struct LEScanCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .leScan
    
    public var duration: TimeInterval
    
    // MARK: - Initialization
    
    public init(options: [Option: String]) throws {
        
        guard options.count == 1
            else { throw CommandError.invalidArgumentsCount(expected: 1, actual: arguments.count) }
        
        let durationString = options[]
        
        guard let duration = TimeInterval(durationString)
            else { throw Error.invalidDuration() }
    }
    
    // MARK: - Methods
    
    public func execute() {
        
        
    }
}

public extension LEScanCommand {
    
    public enum Option: String {
        
        case duration
    }
}

public extension LEScanCommand {
    
    public enum Error: Swift.Error {
        
        case invalidDuration(String)
    }
}

/// Tests the Scanning functionality.
func LEScanTest(controller: HostController, duration: TimeInterval) {
    
    print("Scanning for \(duration) seconds...")
    
    let startDate = Date()
    let endDate = startDate + duration
    
    do { try controller.lowEnergyScan(shouldContinue: { Date() < endDate },
                                   foundDevice: { print($0.address) }) }
        
    catch { print("Could not scan: \(error)") }
}

