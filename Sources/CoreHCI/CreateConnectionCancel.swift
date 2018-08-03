//
//  CreateConnectionCancel.swift
//  hcitool
//
//  Created by Carlos Duclos on 8/3/18.
//
//

import Bluetooth
import Foundation

public struct CreateConnectionCancelCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .createConnectionCancel
    
    public let address: Address
    
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
    
    /// Tests the creation of connection cancel
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.cancelConnection(address: address)
    }
}

public extension CreateConnectionCancelCommand {
    
    public enum Option: String, OptionProtocol {
        
        case address = "address"
        
        public static let all: Set<Option> = [.address]
    }
}
