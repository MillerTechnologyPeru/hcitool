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

public struct LEScanCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .leScan
    
    public var duration: TimeInterval
    
    // MARK: - Initialization
    
    public static let `default` = LEScanCommand(duration: 10.0)
    
    public init(duration: TimeInterval) {
        
        self.duration = duration
    }
    
    public init(options: [Option: String]) throws {
        
        if let durationString = options[.duration] {
            
            guard let duration = TimeInterval(durationString)
                else { throw CommandError.invalidOptionValue(option: Option.duration.rawValue, value: durationString) }
            
            self.duration = duration
            
        } else {
            
            self.duration = type(of: self).default.duration
        }
    }
    
    // MARK: - Methods
    
    /// Tests the Scanning functionality.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        print("Scanning for \(duration) seconds...")
        
        let startDate = Date()
        let endDate = startDate + duration
        
        try controller.lowEnergyScan(shouldContinue: { Date() < endDate },
                                     foundDevice: { print($0.address) })
    }
}

public extension LEScanCommand {
    
    public enum Option: String, OptionProtocol {
        
        case duration
        
        public static let all: Set<Option> = [.duration]
    }
}
