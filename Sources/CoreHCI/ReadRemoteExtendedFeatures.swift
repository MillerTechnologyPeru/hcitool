//
//  ReadRemoteExtendedFeatures.swift
//  hcitool
//
//  Created by Carlos Duclos on 8/8/18.
//
//

import Bluetooth
import Foundation

public struct ReadRemoteExtendedFeaturesCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .readRemoteSupportedFeatures
    
    public var connectionHandle: UInt16
    
    public var pageNumber: UInt8
    
    // MARK: - Initialization
    
    public init(connectionHandle: UInt16, pageNumber: UInt8) {
        
        self.connectionHandle = connectionHandle
        self.pageNumber = pageNumber
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let handleString = parameters.first(where: { $0.option == .connectionHandle })?.value
            else { throw CommandError.optionMissingValue(Option.connectionHandle.rawValue) }
        
        guard let handle = UInt16(commandLine: handleString)
            else { throw CommandError.invalidOptionValue(option: Option.connectionHandle.rawValue, value: handleString) }
        
        self.connectionHandle = handle
        
        guard let pageNumberString = parameters.first(where: { $0.option == .pageNumber })?.value
            else { throw CommandError.optionMissingValue(Option.pageNumber.rawValue) }
        
        guard let pageNumber = UInt8(commandLine: pageNumberString)
            else { throw CommandError.invalidOptionValue(option: Option.pageNumber.rawValue, value: pageNumberString) }
        
        self.pageNumber = pageNumber
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let features = try controller.readRemoteExtendedFeatures(handle: connectionHandle, pageNumber: pageNumber)
        
        print("LMP Features: \n")
        
        features.forEach { print($0.name) }
    }
}

public extension ReadRemoteExtendedFeaturesCommand {
    
    public enum Option: String, OptionProtocol {
        
        case connectionHandle = "connectionhandle"
        case pageNumber = "pagenumber"
        
        public static let all: Set<Option> = [.connectionHandle, .pageNumber]
    }
}
