//
//  LEReadChannelMap.swift
//  hcitool
//
//  Created by Marco Estrella on 4/28/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEStartEncryptionCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyLongTermKeyRequestReply
    
    public var connectionHandle: UInt16
    public let randomNumber: UInt64
    public let encryptedDiversifier: UInt16
    public var longTermKey: UInt128
    
    // MARK: - Initialization
    
    public init(connectionHandle: UInt16, randomNumber: UInt64, encryptedDiversifier: UInt16, longTermKey: UInt128) {
        
        self.connectionHandle = connectionHandle
        self.randomNumber = randomNumber
        self.encryptedDiversifier = encryptedDiversifier
        self.longTermKey = longTermKey
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let handleString = parameters.first(where: { $0.option == .connectionHandle })?.value
            else { throw CommandError.optionMissingValue(Option.connectionHandle.rawValue) }
        
        guard let handle = UInt16(commandLine: handleString)
            else { throw CommandError.invalidOptionValue(option: Option.connectionHandle.rawValue, value: handleString) }
        
        guard let randomNumberString = parameters.first(where: { $0.option == .randomNumber })?.value
            else { throw CommandError.optionMissingValue(Option.randomNumber.rawValue) }
        
        guard let randomNumber = UInt64(commandLine: randomNumberString)
            else { throw CommandError.invalidOptionValue(option: Option.randomNumber.rawValue, value: randomNumberString) }
        
        guard let encryptedDiversifierString = parameters.first(where: { $0.option == .encryptedDiversifier })?.value
            else { throw CommandError.optionMissingValue(Option.encryptedDiversifier.rawValue) }
        
        guard let encryptedDiversifier = UInt16(commandLine: encryptedDiversifierString)
            else { throw CommandError.invalidOptionValue(option: Option.encryptedDiversifier.rawValue, value: encryptedDiversifierString) }
        
        guard let longTermKeyString = parameters.first(where: { $0.option == .longTermKey })?.value.removeHexadecimalPrefix()
            else { throw CommandError.optionMissingValue(Option.longTermKey.rawValue) }
        
        guard let longTermKeyData = longTermKeyString.data(using: .utf8),
            let longTermKey = UInt128.init(data: longTermKeyData)
            else { throw CommandError.invalidOptionValue(option: Option.longTermKey.rawValue, value: longTermKeyString) }
        
        self.connectionHandle = handle
        self.encryptedDiversifier = encryptedDiversifier
        self.randomNumber = randomNumber
        self.longTermKey = longTermKey
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.lowEnergyStartEncryption(connectionHandle: connectionHandle, randomNumber: randomNumber,
                                                             encryptedDiversifier: encryptedDiversifier, longTermKey: longTermKey)
    }
}

public extension LEStartEncryptionCommand {
    
    public enum Option: String, OptionProtocol {
        
        case connectionHandle = "connectionhandle"
        case randomNumber     = "randomnumber"
        case encryptedDiversifier = "encrypteddiversifier"
        case longTermKey      = "longtermkey"
        
        public static let all: Set<Option> = [.connectionHandle, .randomNumber, .encryptedDiversifier, .longTermKey]
    }
}



