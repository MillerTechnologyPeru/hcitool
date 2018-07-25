//
//  SetRandomAddress.swift
//  hcitool
//
//  Created by Marco Estrella on 4/24/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LESetRandomAddressCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergySetRandomAddress
    
    public var address: Address
    
    // MARK: - Initialization
    
    public init(address: Address) {
        
        self.address = address
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let addressString = parameters.first(where: { $0.option == .address })?.value
            else { throw CommandError.optionMissingValue(Option.address.rawValue) }
        
        guard let address = Address(rawValue: addressString)
            else { throw CommandError.invalidOptionValue(option: Option.address.rawValue, value: addressString) }
        
        self.address = address
    }
    
    // MARK: - Methods
    
    /// Tests the Setting of Random Address.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.lowEnergySetRandomAddress(address)
        
        print("Set LE Random Address: \(address)")
    }
}

public extension LESetRandomAddressCommand {
    
    public enum Option: String, OptionProtocol {
        
        case address
        
        public static let all: Set<Option> = [.address]
    }
}
