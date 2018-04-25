//
//  SetRandomAddress.swift
//  hcitool
//
//  Created by Marco Estrella on 4/24/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct SetRandomAddressCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .setRandomAddress
    
    public var randomAddress: String
    
    // MARK: - Initialization
    
    public init(randomAddress: String){
        self.randomAddress = randomAddress
    }
    
    public init(options: [Option: String]) throws {
        
        guard let randomAddressString = options[.randomAddress]
            else { throw CommandError.optionMissingValue(Option.randomAddress.rawValue) }
        
        self.randomAddress = randomAddressString
    }
    
    // MARK: - Methods
    
    /// Tests the Setting of Random Address.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        guard let address = Address(rawValue: randomAddress)
            else { throw CommandError.invalidOptionValue(option: "address", value: randomAddress)}
        
        try controller.lowEnergySetRandomAddress(address)
        
        print("Set Random Address: \(randomAddress)")
    }
}

public extension SetRandomAddressCommand {
    
    public enum Option: String, OptionProtocol {
        
        case randomAddress
        
        public static let all: Set<Option> = [.randomAddress]
    }
}
