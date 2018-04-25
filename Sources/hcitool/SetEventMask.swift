//
//  SetEventMask.swift
//  hcitool
//
//  Created by Marco Estrella on 4/25/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct SetEventMaskCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .setEventMask
    
    public var eventMask: LowEnergyCommand.SetEventMaskParameter.EventMask
    
    // MARK: - Initialization
    
    public init(eventMask: LowEnergyCommand.SetEventMaskParameter.EventMask){
        self.eventMask = eventMask
    }
    
    public init(options: [Option: String]) throws {
        
        /*
        guard let eventMask = options[.eventMask]
            else { throw CommandError.optionMissingValue(Option.eventMask.rawValue) }
        */
        //TODO: Add eventMask option
        self.eventMask = LowEnergyCommand.SetEventMaskParameter.EventMask.connectionComplete
    }
    
    // MARK: - Methods
    
    /// Tests Setting of Event Mask.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.setEventMask(eventMask: eventMask)
        
        print("Event Mask: \(eventMask)")
    }
}

public extension SetEventMaskCommand {
    
    public enum Option: String, OptionProtocol {
        
        case eventMask = "eventmask"
        
        public static let all: Set<Option> = [.eventMask]
    }
}
