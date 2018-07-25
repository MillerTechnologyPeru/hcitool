//
//  LEWriteSuggestedDefaultDataLength.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/23/18.
//
//

import Bluetooth
import Foundation

public struct LEWriteSuggestedDefaultDataLengthCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyWriteSuggestedDefaultDataLength
    
    public var suggestedMaxTxOctets: LowEnergyMaxTxOctets
    
    public var suggestedMaxTxTime: LowEnergyMaxTxTime
    
    // MARK: - Initializers
    
    public init(suggestedMaxTxOctets: LowEnergyMaxTxOctets, suggestedMaxTxTime: LowEnergyMaxTxTime) {
    
        self.suggestedMaxTxOctets = suggestedMaxTxOctets
        self.suggestedMaxTxTime = suggestedMaxTxTime
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let suggestedMaxTxOctetsString = parameters.first(where: { $0.option == .suggestedMaxTxOctets })?.value
            else { throw CommandError.optionMissingValue(Option.suggestedMaxTxOctets.rawValue) }
        
        guard let suggestedMaxTxOctetsHandle = UInt16(commandLine: suggestedMaxTxOctetsString),
            let suggestedMaxTxOctets = LowEnergyMaxTxOctets(rawValue: suggestedMaxTxOctetsHandle)
            else { throw CommandError.invalidOptionValue(option: Option.suggestedMaxTxOctets.rawValue, value: suggestedMaxTxOctetsString) }
        
        self.suggestedMaxTxOctets = suggestedMaxTxOctets
        
        guard let suggestedMaxTxTimeString = parameters.first(where: { $0.option == .suggestedMaxTxTime })?.value
            else { throw CommandError.optionMissingValue(Option.suggestedMaxTxTime.rawValue) }
        
        guard let suggestedMaxTxTimeHandle = UInt16(commandLine: suggestedMaxTxTimeString),
            let suggestedMaxTxTime = LowEnergyMaxTxTime(rawValue: suggestedMaxTxTimeHandle)
            else { throw CommandError.invalidOptionValue(option: Option.suggestedMaxTxTime.rawValue, value: suggestedMaxTxTimeString) }
        
        self.suggestedMaxTxTime = suggestedMaxTxTime
    }
    
    // MARK: - Methods
    
    public func execute<Controller>(controller: Controller) throws where Controller : BluetoothHostControllerInterface {
        
        try controller.lowEnergyWriteSuggestedDefaultDataLength(suggestedMaxTxOctets: suggestedMaxTxOctets,
                                                                suggestedMaxTxTime: suggestedMaxTxTime)
    }
}

public extension LEWriteSuggestedDefaultDataLengthCommand {
    
    public enum Option: String, OptionProtocol {
        
        case suggestedMaxTxOctets = "suggestedmaxtxoctets"
        
        case suggestedMaxTxTime = "suggestedmaxtxtime"
        
        public static let all: Set<Option> = [.suggestedMaxTxOctets, .suggestedMaxTxTime]
    }
}
