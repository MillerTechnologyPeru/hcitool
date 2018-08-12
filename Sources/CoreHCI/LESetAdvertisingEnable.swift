//
//  LESetAdvertisingEnable.swift
//  hcitool
//
//  Created by Marco Estrella on 5/8/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LESetAdvertisingEnableCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergySetAdvertisingEnable
    
    public var enable: Bool
    
    // MARK: - Initialization
    
    public init(enable: Bool = true) {
        
        self.enable = enable
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        if let enableString = parameters.first(where: { $0.option == .enable })?.value {
            
            guard let enable = CommandLineBool(rawValue: enableString)
                else { throw CommandError.invalidOptionValue(option: Option.enable.rawValue, value: enableString) }
            
            self.enable = enable.boolValue
            
        } else {
            
            // default value
            self.enable = true
        }
    }
    
    // MARK: - Methods
    
    /// Tests Setting of Event Mask.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {

        try controller.enableLowEnergyAdvertising(enable)
        
        print("\(enable ? "Enabled" : "Disabled") LE Advertising")
    }
}

public extension LESetAdvertisingEnableCommand {
    
    public enum Option: String, OptionProtocol {
        
        case enable
        
        public static let all: Set<Option> = [.enable]
    }
}
