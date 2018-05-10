//
//  LEReadChannelMap.swift
//  hcitool
//
//  Created by Marco Estrella on 4/28/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LELongTermKeyRequestNegativeReplyCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyLongTermKeyRequestNegativeReply
    
    public var connectionHandle: UInt16
    
    // MARK: - Initialization
    
    public init(connectionHandle: UInt16) {
        
        self.connectionHandle = connectionHandle
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let handleString = parameters.first(where: { $0.option == .connectionHandle })?.value
            else { throw CommandError.optionMissingValue(Option.connectionHandle.rawValue) }
        
        guard let handle = UInt16(commandLine: handleString)
            else { throw CommandError.invalidOptionValue(option: Option.connectionHandle.rawValue, value: handleString) }
        
        self.connectionHandle = handle
    }
    
    // MARK: - Methods
    
    /// Tests the Setting of Random Address.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let handle = try controller.lowEnergyLongTermKeyRequestNegativeReply(handle: connectionHandle)
        
        print("Connection Handle: \(handle)")
    }
}

public extension LELongTermKeyRequestNegativeReplyCommand {
    
    public enum Option: String, OptionProtocol {
        
        case connectionHandle = "connectionhandle"
        
        public static let all: Set<Option> = [.connectionHandle]
    }
}

