//
//  LESetEventMask.swift
//  hcitool
//
//  Created by Marco Estrella on 4/25/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LESetEventMaskCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergySetEventMask
    
    public var events: [Event]
    
    // MARK: - Initialization
    
    public init(events: [Event] = []) {
        
        self.events = events
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        var events = [Event]()
        events.reserveCapacity(parameters.count)
        
        for parameter in parameters {
            
            switch parameter.option {
                
            case .event:
                
                guard let event = Event(rawValue: parameter.value)
                    else { throw CommandError.invalidOptionValue(option: Option.event.rawValue,
                                                                 value: parameter.value) }
                
                events.append(event)
            }
        }
        
        self.events = events
    }
    
    // MARK: - Methods
    
    /// Tests Setting of Event Mask.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        typealias EventMask = LowEnergyCommand.SetEventMaskParameter.EventMask
        let events = self.events.map { $0.hciValue }
        let eventMask = EventMask(events)
        
        try controller.setLowEnergyEventMask(eventMask)
        
        print("LE Event Mask: \(eventMask)")
    }
}

public extension LESetEventMaskCommand {
    
    public enum Option: String, OptionProtocol {
        
        case event
        
        public static let all: Set<Option> = [.event]
    }
}

public extension LESetEventMaskCommand {
    
    public enum Event: String {
        
        public typealias HCIValue = LowEnergyCommand.SetEventMaskParameter.Event
        
        case connectionComplete = "connectioncomplete"
        case advertisingReport = "advertisingreport"
        
        public var hciValue: HCIValue {
            
            switch self {
            case .connectionComplete: return .connectionComplete
            case .advertisingReport: return .advertisingReport
            }
        }
    }
}
