//
//  LEReadChannelMap.swift
//  hcitool
//
//  Created by Marco Estrella on 4/28/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEReadChannelMapCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReadChannelMap
    
    public var handle: UInt16
    
    // MARK: - Initialization
    
    public init(handle: UInt16) {
        
        self.handle = handle
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let handleString = parameters.first(where: { $0.option == .handle })?.value
            else { throw CommandError.optionMissingValue(Option.handle.rawValue) }

        guard let handle = UInt16(commandLine: handleString)
            else { throw CommandError.invalidOptionValue(option: Option.handle.rawValue, value: handleString) }
        
        self.handle = handle
    }
    
    // MARK: - Methods
    
    /// Tests the Setting of Random Address.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let returnValues = try controller.lowEnergyReadChannelMap(handle: handle)
        
        print("Set LE ChannelMap: \(returnValues)")
    }
}

public extension LEReadChannelMapCommand {
    
    public enum Option: String, OptionProtocol {
        
        case handle
        
        public static let all: Set<Option> = [.handle]
    }
}
