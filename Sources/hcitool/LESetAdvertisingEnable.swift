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
    
    public static let commandType: CommandType = .lowEnergySetEventMask
    
    public var enable: Bool
    
    // MARK: - Initialization
    
    public init(enable: Bool) {
        
        self.enable = enable
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let enableString = parameters.first(where: { $0.option == .enable })?.value,
            let enable = CommandLineBool(rawValue: enableString)
            else { throw CommandError.optionMissingValue(Option.enable.rawValue) }
        
        self.enable = enable.boolValue
    }
    
    // MARK: - Methods
    
    /// Tests Setting of Event Mask.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {

        try controller.enableLowEnergyAdvertising(enable)
    }
}

public extension LESetAdvertisingEnableCommand {
    
    public enum Option: String, OptionProtocol {
        
        case enable
        
        public static let all: Set<Option> = [.enable]
    }
}
