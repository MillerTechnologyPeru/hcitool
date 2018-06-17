//
//  iBeacon.swift
//  hcitool
//
//  Created by Alsey Coleman Miller on 3/27/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

/// Well known iBeacon UUID
private let iBeaconUUID = Foundation.UUID(rawValue: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!

/// Tests iBeacon advertising
public struct iBeaconCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .iBeacon
    
    public var uuid: UUID
    
    public var major: UInt16
    
    public var minor: UInt16
    
    public var rssi: Int8
    
    public var interval: AdvertisingInterval
    
    public var duration: TimeInterval
    
    public static let `default` = iBeaconCommand(uuid: iBeaconUUID,
                                                 major: 1,
                                                 minor: 1,
                                                 rssi: -29,
                                                 interval: .default,
                                                 duration: 30)
    
    // MARK: - Initialization
    
    public init(uuid: UUID,
                major: UInt16,
                minor: UInt16,
                rssi: Int8,
                interval: AdvertisingInterval,
                duration: TimeInterval) {
        
        self.uuid = uuid
        self.major = major
        self.minor = minor
        self.rssi = rssi
        self.interval = interval
        self.duration = duration
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        if let stringValue = parameters.first(where: { $0.option == .uuid })?.value {
            
            guard let value = UUID(uuidString: stringValue)
                else { throw CommandError.invalidOptionValue(option: Option.uuid.rawValue, value: stringValue) }
            
            self.uuid = value
            
        } else {
            
            self.uuid = type(of: self).default.uuid
        }
        
        if let stringValue = parameters.first(where: { $0.option == .major })?.value {
            
            guard let value =  UInt16(stringValue)
                else { throw CommandError.invalidOptionValue(option: Option.major.rawValue, value: stringValue) }
            
            self.major = value
            
        } else {
            
            self.major = type(of: self).default.major
        }
        
        if let stringValue = parameters.first(where: { $0.option == .minor })?.value {
            
            guard let value =  UInt16(stringValue)
                else { throw CommandError.invalidOptionValue(option: Option.minor.rawValue, value: stringValue) }
            
            self.minor = value
            
        } else {
            
            self.minor = type(of: self).default.minor
        }
        
        if let stringValue = parameters.first(where: { $0.option == .rssi })?.value {
            
            guard let value =  Int8(stringValue)
                else { throw CommandError.invalidOptionValue(option: Option.rssi.rawValue, value: stringValue) }
            
            self.rssi = value
            
        } else {
            
            self.rssi = type(of: self).default.rssi
        }
        
        if let stringValue = parameters.first(where: { $0.option == .interval })?.value {
            
            guard let rawValue =  UInt16(stringValue),
                let value = AdvertisingInterval(rawValue: rawValue)
                else { throw CommandError.invalidOptionValue(option: Option.interval.rawValue, value: stringValue) }
            
            self.interval = value
            
        } else {
            
            self.interval = type(of: self).default.interval
        }
        
        if let durationString = parameters.first(where: { $0.option == .duration })?.value {
            
            guard let duration = TimeInterval(durationString)
                else { throw CommandError.invalidOptionValue(option: Option.duration.rawValue, value: durationString) }
            
            self.duration = duration
            
        } else {
            
            self.duration = type(of: self).default.duration
        }
    }
    
    // MARK: - Methods
    
    /// Tests iBeacon advertising.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        print("Enabling iBeacon \(uuid) for \(duration) seconds")
        
        let beacon = AppleBeacon(uuid: uuid, major: major, minor: minor, rssi: rssi)
        
        let flags = GAPFlags(flags: [.lowEnergyGeneralDiscoverableMode])
        
        try controller.iBeacon(beacon, flags: flags, interval: interval)
        
        // sleep
        sleep(UInt32(duration))
        
        try controller.enableLowEnergyAdvertising(false)
    }
}

public extension iBeaconCommand {
    
    public enum Option: String, OptionProtocol {
        
        case uuid
        case major
        case minor
        case rssi
        case interval
        case duration
        
        public static let all: Set<Option> = [.duration]
    }
}
