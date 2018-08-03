//
//  Disconnect.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/27/18.
//
//

import Bluetooth
import Foundation

import Bluetooth
import Foundation

public struct DisconnectCommand: ArgumentableCommand {
    
    public typealias Reason = HCIDisconnect.Reason
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .disconnect
    
    public let connectionHandle: UInt16
    
    public let reason: HCIError
    
    // MARK: - Initialization
    
    public init(connectionHandle: UInt16, reason: HCIError) {
        
        self.connectionHandle = connectionHandle
        self.reason = reason
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let connectionHandleString = parameters.first(where: { $0.option == .connectionHandle })?.value
            else { throw CommandError.optionMissingValue(Option.connectionHandle.rawValue) }
        
        guard let connectionHandle = UInt16(commandLine: connectionHandleString)
            else { throw CommandError.invalidOptionValue(option: Option.connectionHandle.rawValue, value: connectionHandleString) }
        
        self.connectionHandle = connectionHandle
        
        guard let reasonString = parameters.first(where: { $0.option == .reason })?.value
            else { throw CommandError.optionMissingValue(Option.reason.rawValue) }
        
        guard let reasonValue = UInt8(commandLine: reasonString), let reason = HCIError(rawValue: reasonValue)
            else { throw CommandError.invalidOptionValue(option: Option.reason.rawValue, value: reasonString) }
        
        self.reason = reason
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let disconnectionComplete = try controller.disconnect(connectionHandle: connectionHandle,
                                                              error: reason,
                                                              timeout: 5000)
        
        print("handle =", disconnectionComplete.handle)
        print("status =", disconnectionComplete.status.description)
        print("reason =", disconnectionComplete.error.rawValue)
    }
}

public extension DisconnectCommand {
    
    public enum Option: String, OptionProtocol {
        
        case connectionHandle = "connectionHandle"
        case reason = "reason"
        
        public static let all: Set<Option> = [.connectionHandle, .reason]
    }
}
