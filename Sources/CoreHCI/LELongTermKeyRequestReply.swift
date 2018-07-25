//
//  LEReadChannelMap.swift
//  hcitool
//
//  Created by Marco Estrella on 4/28/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LELongTermKeyRequestReplyCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyLongTermKeyRequestReply
    
    public var connectionHandle: UInt16
    public var longTermKey: UInt128
    
    // MARK: - Initialization
    
    public init(connectionHandle: UInt16, longTermKey: UInt128) {
        
        self.connectionHandle = connectionHandle
        self.longTermKey = longTermKey
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let handleString = parameters.first(where: { $0.option == .connectionHandle })?.value
            else { throw CommandError.optionMissingValue(Option.connectionHandle.rawValue) }
        
        guard let handle = UInt16(commandLine: handleString)
            else { throw CommandError.invalidOptionValue(option: Option.connectionHandle.rawValue, value: handleString) }
        
        guard let longTermKeyString = parameters.first(where: { $0.option == .longTermKey })?.value.removeHexadecimalPrefix()
            else { throw CommandError.optionMissingValue(Option.longTermKey.rawValue) }
        
        guard let longTermKey = UInt128.init(commandLine: longTermKeyString)
            else { throw CommandError.invalidOptionValue(option: Option.longTermKey.rawValue, value: longTermKeyString) }
        
        self.connectionHandle = handle
        self.longTermKey = longTermKey
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let handle = try controller.lowEnergyLongTermKeyRequestReply(handle: connectionHandle, longTermKey: longTermKey)
        
        print("Connection Handle: \(handle)")
    }
}

public extension LELongTermKeyRequestReplyCommand {
    
    public enum Option: String, OptionProtocol {
        
        case connectionHandle = "connectionhandle"
        case longTermKey      = "longtermkey"
        
        public static let all: Set<Option> = [.connectionHandle, .longTermKey]
    }
}


