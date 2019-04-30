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
        
        typealias EventMask = HCILESetEventMask.EventMask
        let events = self.events.map { $0.hciValue }
        let eventMask = EventMask(events)
        
        try controller.setLowEnergyEventMask(eventMask)
        
        print("LE Event Mask: \(eventMask)")
    }
}

public extension LESetEventMaskCommand {
    
    enum Option: String, OptionProtocol {
        
        case event
        
        public static let all: Set<Option> = [.event]
    }
}

public extension LESetEventMaskCommand {
    
    enum Event: String {
        
        public typealias HCIValue = HCILESetEventMask.Event
        
        case connectionComplete = "connectioncomplete"
        case advertisingReport = "advertisingreport"
        case connectionUpdateComplete = "connectionupdatecomplete"
        case readRemoteFeaturesComplete = "readremotefeaturescomplete"
        case longTermKeyRequest = "longtermKeyrequest"
        case remoteConnectionParameterRequest = "remoteconnectionparameterrequest"
        case dataLengthChange = "datalengthchange"
        case readLocalP256PublicKeyComplete = "readlocalp256publickeycomplete"
        case generateDhkeyComplete = "generatedhkeycomplete"
        case enhancedConnectionComplete = "enhancedconnectioncomplete"
        case directedAdvertisingReport = "directedadvertisingreport"
        case phyUpdateComplete = "phyupdatecomplete"
        case extendedAdvertisingReport = "extendedadvertisingreport"
        case periodicAdvertisingSyncEstablished = "periodicadvertisingsyncestablished"
        case periodicAdvertisingReport = "periodicadvertisingreport"
        case periodicAdvertisingSyncLost = "periodicadvertisingsynclost"
        case extendedScanTimeout = "extendedscantimeout"
        case extendedAdvertisingSetTerminated = "extendedadvertisingsetterminated"
        case scanRequestReceived = "scanrequestreceived"
        case channelSelectionAlgorithm = "channelselectionalgorithm"
        
        public var hciValue: HCIValue {
            
            switch self {
            case .connectionComplete: return .connectionComplete
            case .advertisingReport: return .advertisingReport
            case .connectionUpdateComplete: return .connectionUpdateComplete
            case .readRemoteFeaturesComplete: return .readRemoteFeaturesComplete
            case .longTermKeyRequest: return .longTermKeyRequest
            case .remoteConnectionParameterRequest: return .remoteConnectionParameterRequest
            case .dataLengthChange: return .dataLengthChange
            case .readLocalP256PublicKeyComplete: return .readLocalP256PublicKeyComplete
            case .generateDhkeyComplete: return .generateDHKeyComplete
            case .enhancedConnectionComplete: return .enhancedConnectionComplete
            case .directedAdvertisingReport: return .directedAdvertisingReport
            case .phyUpdateComplete: return .phyUpdateComplete
            case .extendedAdvertisingReport: return .extendedAdvertisingReport
            case .periodicAdvertisingSyncEstablished: return .periodicAdvertisingSyncEstablished
            case .periodicAdvertisingReport: return .periodicAdvertisingReport
            case .periodicAdvertisingSyncLost: return .periodicAdvertisingSyncLost
            case .extendedScanTimeout: return .extendedScanTimeout
            case .extendedAdvertisingSetTerminated: return .extendedAdvertisingSetTerminated
            case .scanRequestReceived: return .scanRequestReceived
            case .channelSelectionAlgorithm: return .channelSelectionAlgorithm
            }
        }
    }
}
