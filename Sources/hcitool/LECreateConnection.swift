//
//  LECreateConnection.swift
//  hcitool
//
//  Created by Marco Estrella on 5/8/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LECreateConnectionCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyCreateConnection
    
    public let scanInterval: LowEnergyScanTimeInterval
    public let scanWindow: LowEnergyScanTimeInterval
    public let initiatorFilterPolicy: LowEnergyCommand.CreateConnectionParameter.InitiatorFilterPolicy
    public let peerAddressType: LowEnergyAddressType
    public let peerAddress: Address
    public let ownAddressType: LowEnergyAddressType
    public var interval: LowEnergyConnectionIntervalRange
    public var latency: LowEnergyConnectionLatency
    public var supervisionTimeout: LowEnergySupervisionTimeout
    public let connectionLength: LowEnergyConnectionLength
    
    // MARK: - Initialization
    
    public init(scanInterval: LowEnergyScanTimeInterval,
                scanWindow: LowEnergyScanTimeInterval,
                initiatorFilterPolicy: LowEnergyCommand.CreateConnectionParameter.InitiatorFilterPolicy = .peerAddress,
                peerAddressType: LowEnergyAddressType = .public,
                peerAddress: Address,
                ownAddressType: LowEnergyAddressType = .public,
                connectionInterval: LowEnergyConnectionIntervalRange = .full,
                connectionLatency: LowEnergyConnectionLatency = .zero,
                supervisionTimeout: LowEnergySupervisionTimeout = .max,
                connectionLength: LowEnergyConnectionLength = .full) {
        
        self.scanInterval = scanInterval
        self.scanWindow = scanWindow
        self.initiatorFilterPolicy = initiatorFilterPolicy
        self.peerAddressType = peerAddressType
        self.peerAddress = peerAddress
        self.ownAddressType = ownAddressType
        self.interval = connectionInterval
        self.latency = connectionLatency
        self.supervisionTimeout = supervisionTimeout
        self.connectionLength = connectionLength
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let scanIntervalString = parameters.first(where: { $0.option == .scanInterval })?.value,
            let scanIntervalUInt16 = UInt16(scanIntervalString),
            let scanInterval = LowEnergyScanTimeInterval(rawValue: scanIntervalUInt16)
            else { throw CommandError.optionMissingValue(Option.scanInterval.rawValue) }
        
        guard let scanWindowString = parameters.first(where: { $0.option == .scanWindow })?.value,
            let scanWindowUInt16 = UInt16(scanWindowString),
            let scanWindow = LowEnergyScanTimeInterval(rawValue: scanWindowUInt16)
            else { throw CommandError.optionMissingValue(Option.scanWindow.rawValue) }
        
        guard let filterPolicyString = parameters.first(where: { $0.option == .initiatorFilterPolicy })?.value,
            let initiatorFilterPolicy = InitiatorFilterPolicy(rawValue: filterPolicyString)
            else { throw CommandError.invalidOption(Option.initiatorFilterPolicy.rawValue) }
        
        guard let peerAddressTypeString = parameters.first(where: { $0.option == .peerAddressType })?.value,
            let peerAddressType = AddressType(rawValue: peerAddressTypeString)
            else { throw CommandError.invalidOption(Option.peerAddressType.rawValue) }
        
        guard let peerAddressString = parameters.first(where: { $0.option == .peerAddress })?.value,
            let peerAddress = Address(rawValue: peerAddressString)
            else { throw CommandError.optionMissingValue(Option.peerAddress.rawValue) }

        guard let ownAddressTypeString = parameters.first(where: { $0.option == .ownAddressType })?.value,
            let ownAddressType = AddressType(rawValue: ownAddressTypeString)
            else { throw CommandError.invalidOption(Option.ownAddressType.rawValue) }
        
        guard let intervalMinString = parameters.first(where: { $0.option == .intervalMin })?.value,
            let intervalMin = UInt16(intervalMinString)
            else { throw CommandError.optionMissingValue(Option.intervalMin.rawValue) }
        
        guard let intervalMaxString = parameters.first(where: { $0.option == .intervalMax })?.value,
            let intervalMax = UInt16(intervalMaxString)
            else { throw CommandError.optionMissingValue(Option.intervalMax.rawValue) }
        
        guard let interval = LowEnergyConnectionIntervalRange(rawValue: intervalMin ... intervalMax)
            else { throw CommandError.optionMissingValue("LowEnergyConnectionIntervalRange") }
        
        guard let latencyString = parameters.first(where: { $0.option == .latency })?.value,
            let latencyUInt16 = UInt16(latencyString),
            let latency = LowEnergyConnectionLatency(rawValue: latencyUInt16)
            else { throw CommandError.optionMissingValue(Option.latency.rawValue) }
        
        guard let supervisionTimeoutString = parameters.first(where: { $0.option == .supervisionTimeout })?.value,
            let supervisionTimeoutUInt16 = UInt16(supervisionTimeoutString),
            let supervisionTimeout = LowEnergySupervisionTimeout(rawValue: supervisionTimeoutUInt16)
            else { throw CommandError.optionMissingValue(Option.supervisionTimeout.rawValue) }
        
        guard let lengthMinString = parameters.first(where: { $0.option == .lengthMin })?.value,
            let lengthMin = UInt16(lengthMinString)
            else { throw CommandError.optionMissingValue(Option.lengthMin.rawValue) }
        
        guard let lengthMaxString = parameters.first(where: { $0.option == .lengthMax })?.value,
            let lengthMax = UInt16(lengthMaxString)
            else { throw CommandError.optionMissingValue(Option.lengthMax.rawValue) }
        
        self.scanInterval = scanInterval
        self.scanWindow = scanWindow
        self.initiatorFilterPolicy = initiatorFilterPolicy.hciValue
        self.peerAddressType = peerAddressType.hciValue
        self.peerAddress = peerAddress
        self.ownAddressType = ownAddressType.hciValue
        self.interval = interval
        self.latency = latency
        self.supervisionTimeout = supervisionTimeout
        self.connectionLength = LowEnergyConnectionLength(rawValue: lengthMin ... lengthMax)
    }
    
    // MARK: - Methods
    
    /// Tests the Setting of Random Address.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let parameters = LowEnergyCommand.CreateConnectionParameter(scanInterval: scanInterval, scanWindow: scanWindow, initiatorFilterPolicy: initiatorFilterPolicy, peerAddressType: peerAddressType, peerAddress: peerAddress, ownAddressType: ownAddressType, connectionInterval: interval, connectionLatency: latency, supervisionTimeout: supervisionTimeout, connectionLength: connectionLength)
        
        let connectionComplete = try controller.lowEnergyCreateConnection(parameters: parameters)
        
        print("handle = \(connectionComplete.handle)")
        print("interval = \(connectionComplete.interval.miliseconds)")
        print("latency = \(connectionComplete.latency)")
        print("peerAddress = \(connectionComplete.peerAddress.description)")
        print("peerAddressType = \(connectionComplete.peerAddressType.rawValue.description)")
    }
}

public extension LECreateConnectionCommand {
    
    public enum InitiatorFilterPolicy: String {
        
        public typealias HCIValue = LowEnergyCommand.CreateConnectionParameter.InitiatorFilterPolicy
        
        case peerAddress    = "peeraddress"
        
        case whiteList      = "whitelist"
        
        public var hciValue: HCIValue {
            
            switch self {
                
            case .peerAddress: return .peerAddress
            case .whiteList: return .whiteList
            }
        }
    }
}

public extension LECreateConnectionCommand {
    
    public enum Option: String, OptionProtocol {
        
        case scanInterval       = "scaninterval"
        
        case scanWindow         = "scanwindow"

        case initiatorFilterPolicy  = "initiatorfilterpolicy"
        
        case peerAddressType = "peeraddresstype"
        
        case peerAddress = "peeraddress"
        
        case ownAddressType = "ownaddresstype"
        
        case intervalMin        = "intervalmin"
        
        case intervalMax        = "intervalmax"
        
        case latency
        
        case supervisionTimeout = "supervisiontimeout"
        
        case lengthMin          = "lengthmin"
        
        case lengthMax          = "lengthmax"
        
        public static let all: Set<Option> = [scanInterval, scanWindow, initiatorFilterPolicy, peerAddressType, peerAddress, ownAddressType,
                                              intervalMin, intervalMax, latency, supervisionTimeout, lengthMin, lengthMax]
    }
}


