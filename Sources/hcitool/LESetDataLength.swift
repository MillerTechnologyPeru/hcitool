//
//  LESetDataLength.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/23/18.
//
//

import Bluetooth
import Foundation

public struct LESetDataLengthCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergySetDataLength
    
    public var connectionHandle: UInt16
    
    public var txOctets: LowEnergyMaxTxOctets
    
    public var txTime: LowEnergyMaxTxTime
    
    // MARK: - Initializers
    
    public init(connectionHandle: UInt16, txOctets: LowEnergyMaxTxOctets, txTime: LowEnergyMaxTxTime) {
        
        self.connectionHandle = connectionHandle
        self.txOctets = txOctets
        self.txTime = txTime
    }
    
    public init(parameters: [Parameter<Option>]) throws {

        guard let handleString = parameters.first(where: { $0.option == .connectionHandle })?.value
            else { throw CommandError.optionMissingValue(Option.connectionHandle.rawValue) }
        
        guard let handle = UInt16(commandLine: handleString)
            else { throw CommandError.invalidOptionValue(option: Option.connectionHandle.rawValue, value: handleString) }
        
        self.connectionHandle = handle
        
        guard let txOctetString = parameters.first(where: { $0.option == .txOctet })?.value
            else { throw CommandError.optionMissingValue(Option.txOctet.rawValue) }
        
        guard let txOctetHandle = UInt16(commandLine: txOctetString),
            let txOctets = LowEnergyMaxTxOctets(rawValue: txOctetHandle)
            else { throw CommandError.invalidOptionValue(option: Option.txOctet.rawValue, value: txOctetString) }
        
        self.txOctets = txOctets
        
        guard let txTimeString = parameters.first(where: { $0.option == .txTime })?.value
            else { throw CommandError.optionMissingValue(Option.txTime.rawValue) }
        
        guard let txTimeHandle = UInt16(commandLine: txTimeString),
            let txTime = LowEnergyMaxTxTime(rawValue: txTimeHandle)
            else { throw CommandError.invalidOptionValue(option: Option.txTime.rawValue, value: txTimeString) }
        
        self.txTime = txTime
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let connectionHandle = try controller.lowEnergySetDataLength(connectionHandle: self.connectionHandle,
                                                                     txOctets: self.txOctets,
                                                                     txTime: self.txTime)
        
        print("connection handle = ", connectionHandle)
    }
}

public extension LESetDataLengthCommand {
    
    public enum Option: String, OptionProtocol {
        
        case connectionHandle = "connectionhandle"
        
        case txOctet = "txoctet"
        
        case txTime = "txtime"
        
        public static let all: Set<Option> = [.connectionHandle, .txOctet, .txTime]
    }
}
