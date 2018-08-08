//
//  ReadRemoteVersionInformation.swift
//  hcitool
//
//  Created by Carlos Duclos on 8/8/18.
//
//

import Bluetooth
import Foundation

public struct ReadRemoteVersionInformationCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .readRemoteVersionInformation
    
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
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let versionInformation = try controller.readRemoteVersionInformation(handle: connectionHandle)
        
        print("Version = \(versionInformation.version.toHexadecimal())")
        print("Company ID = \(versionInformation.companyId.toHexadecimal())")
        print("Subversion = \(versionInformation.subversion.toHexadecimal())")
    }
}

public extension ReadRemoteVersionInformationCommand {
    
    public enum Option: String, OptionProtocol {
        
        case connectionHandle = "connectionhandle"
        
        public static let all: Set<Option> = [.connectionHandle]
    }
}

