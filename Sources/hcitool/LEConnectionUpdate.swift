//
//  LEConnectionUpdate.swift
//  hcitool
//
//  Created by Marco Estrella on 5/4/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEConnectionUpdateCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyConnectionUpdate
    
    public var handle: UInt16
    public var interval: LowEnergyConnectionIntervalRange
    public var latency: LowEnergyConnectionLatency
    public var supervisionTimeout: LowEnergySupervisionTimeout
    public let connectionLength: LowEnergyConnectionLength
    
    // MARK: - Initialization
    
    public init(connectionHandle: UInt16,
                connectionInterval: LowEnergyConnectionIntervalRange = .full,
                connectionLatency: LowEnergyConnectionLatency = .zero,
                supervisionTimeout: LowEnergySupervisionTimeout = .max,
                connectionLength: LowEnergyConnectionLength = .full) {
        
        self.handle = connectionHandle
        self.interval = connectionInterval
        self.latency = connectionLatency
        self.supervisionTimeout = supervisionTimeout
        self.connectionLength = connectionLength
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let handleString = parameters.first(where: { $0.option == .handle })?.value.removeHexadecimalPrefix(),
            let handle = UInt16(handleString, radix: 16)
            else { throw CommandError.optionMissingValue(Option.handle.rawValue) }
        
        guard let intervalMinString = parameters.first(where: { $0.option == .intervalMin })?.value,
            let intervalMin = UInt16(intervalMinString)
            else { throw CommandError.optionMissingValue(Option.intervalMin.rawValue) }
        
        guard let intervalMaxString = parameters.first(where: { $0.option == .intervalMax })?.value,
            let intervalMax = UInt16(intervalMaxString)
            else { throw CommandError.optionMissingValue(Option.intervalMax.rawValue) }
        
        guard let interval = LowEnergyConnectionIntervalRange(rawValue: intervalMin ... intervalMax)
            else { throw CommandError.optionMissingValue(Option.intervalMin.rawValue) }
        
        guard let latencyString = parameters.first(where: { $0.option == .latency })?.value.removeHexadecimalPrefix(),
            let latencyUInt16 = UInt16(latencyString, radix: 16),
            let latency = LowEnergyConnectionLatency(rawValue: latencyUInt16)
            else { throw CommandError.optionMissingValue(Option.latency.rawValue) }
        
        guard let supervisionTimeoutString = parameters.first(where: { $0.option == .supervisionTimeout })?.value.removeHexadecimalPrefix(),
            let supervisionTimeoutUInt16 = UInt16(supervisionTimeoutString, radix: 16),
            let supervisionTimeout = LowEnergySupervisionTimeout(rawValue: supervisionTimeoutUInt16)
            else { throw CommandError.optionMissingValue(Option.supervisionTimeout.rawValue) }
        
        guard let lengthMinString = parameters.first(where: { $0.option == .lengthMin })?.value,
            let lengthMin = UInt16(lengthMinString)
            else { throw CommandError.optionMissingValue(Option.lengthMin.rawValue) }
        
        guard let lengthMaxString = parameters.first(where: { $0.option == .lengthMax })?.value,
            let lengthMax = UInt16(lengthMaxString)
            else { throw CommandError.optionMissingValue(Option.lengthMax.rawValue) }
        
        self.handle = handle
        self.interval = interval
        self.latency = latency
        self.supervisionTimeout = supervisionTimeout
        self.connectionLength = LowEnergyConnectionLength(rawValue: lengthMin ... lengthMax)
    }
    
    // MARK: - Methods
    
    /// Tests the Setting of Random Address.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.updateLowEnergyConnection(handle: handle,
                                                 connectionInterval: interval,
                                                 connectionLatency: latency,
                                                 supervisionTimeout: supervisionTimeout,
                                                 connectionLength: connectionLength)
    }
}

public extension LEConnectionUpdateCommand {
    
    public enum Option: String, OptionProtocol {
        
        case handle
        case intervalMin        = "intervalmin"
        case intervalMax        = "intervalmax"
        case latency
        case supervisionTimeout = "supervisiontimeout"
        case lengthMin          = "lengthmin"
        case lengthMax          = "lengthmax"
        
        public static let all: Set<Option> = [.handle, intervalMin, intervalMax, latency, supervisionTimeout, lengthMin, lengthMax]
    }
}

