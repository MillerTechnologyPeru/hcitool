//
//  LEReceiverTest .swift
//  hcitool
//
//  Created by Marco Estrella on 5/11/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LERemoteConnectionParameterRequestNegativeReplyCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReceiverTest
    
    public var connectionHandle: UInt16
    public var reason:  UInt8
    
    // MARK: - Initialization
    
    public init(connectionHandle: UInt16, reason:  UInt8) {
        
        self.connectionHandle = connectionHandle
        self.reason = reason
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let connectionHandleString = parameters.first(where: { $0.option == .connectionHandle })?.value
            else { throw CommandError.optionMissingValue(Option.connectionHandle.rawValue) }
        
        guard let connectionHandle = UInt16(commandLine: connectionHandleString)
            else { throw CommandError.invalidOptionValue(option: Option.connectionHandle.rawValue, value: connectionHandleString) }
        
        
        guard let reasonString = parameters.first(where: { $0.option == .reason })?.value
            else { throw CommandError.optionMissingValue(Option.reason.rawValue) }
        
        guard let reason = UInt8(commandLine: reasonString)
            else { throw CommandError.invalidOptionValue(option: Option.reason.rawValue, value: reasonString) }
        
        self.connectionHandle = connectionHandle
        self.reason = reason
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        //try controller.remot
    }
}

public extension LERemoteConnectionParameterRequestNegativeReplyCommand {
    
    enum Option: String, OptionProtocol {
        
        case connectionHandle = "connectiohandle"
        case reason
        
        public static let all: Set<Option> = [.connectionHandle, .reason]
    }
}



