//
//  LEAddDeviceToWhiteList.swift
//  hcitool
//
//  Created by Marco Estrella on 4/28/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEAddDeviceToWhiteListCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyAddDeviceToWhiteList
    
    public var device: LEWhiteListDevice
    
    // MARK: - Initialization
    
    public init(device: LEWhiteListDevice) {
        
        self.device = device
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let addressTypeString = parameters.first(where: { $0.option == .addressType })?.value
            else { throw CommandError.optionMissingValue(Option.addressType.rawValue) }
        
        guard let addressType = LEWhiteListAddressType(rawValue: addressTypeString)
            else { throw CommandError.invalidOptionValue(option: Option.addressType.rawValue, value: addressTypeString) }
        
        let address: Bluetooth.Address?
        
        if let addressString = parameters.first(where: { $0.option == .address })?.value {
            
            guard let addressValue = Bluetooth.Address(rawValue: addressTypeString)
                else { throw CommandError.invalidOptionValue(option: Option.address.rawValue, value: addressString) }
            
            address = addressValue
            
        } else {
            
            address = nil
        }
        
        guard let device = LEWhiteListDevice(addressType: addressType, address: address)
            else { throw CommandError.missingOption(Option.address.rawValue) } // should only not initialize if we are missing the address value
        
        self.device = device
    }
    
    // MARK: - Methods
    
    /// Tests adding a device to the LE white list.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let whiteListDevice = self.device.hciValue
        
        try controller.lowEnergyAddDeviceToWhiteList(whiteListDevice)
    }
}

public extension LEAddDeviceToWhiteListCommand {
    
    public enum Option: String, OptionProtocol {
        
        case addressType
        case address
        
        public static let all: Set<Option> = [.addressType, .address]
    }
}
