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
    
    public static let commandType: CommandType = .lowEnergyReadChannelMap
    
    public var device: LowEnergyWhiteListDevice
    
    // MARK: - Initialization
    
    public init(device: LowEnergyWhiteListDevice) {
        
        self.device = device
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let addressTypeString = parameters.first(where: { $0.option == .addressType })?.value
            else { throw CommandError.optionMissingValue(Option.addressType.rawValue) }
        
        guard let addressString = parameters.first(where: { $0.option == .address })?.value
            else { throw CommandError.optionMissingValue(Option.address.rawValue) }
        
        guard let addressType = AddressType.init(addressTypeString: addressTypeString, addressString: addressString)
            else { throw CommandError.optionMissingValue(Option.addressType.rawValue) }
        
        self.device = addressType.device
    }
    
    // MARK: - Methods
    
    /// Tests the Setting of Random Address.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.lowEnergyAddDeviceToWhiteList(device)
    }
}

public extension LEAddDeviceToWhiteListCommand {
    
    public enum Option: String, OptionProtocol {
        
        case addressType
        case address
        
        public static let all: Set<Option> = [.addressType, .address]
    }
}

public extension LEAddDeviceToWhiteListCommand {
    
    public enum AddressType {
        
        case `public`(Address)
        case random(Address)
        case anonymous
        
        public init?(addressTypeString: String, addressString: String?){
            
            switch addressTypeString {
            case "public":
                    guard addressString != nil,
                        let address = Address.init(rawValue: addressString!) else { return nil }
                    self = .public(address)
                    break
            case "random":
                    guard addressString != nil,
                        let address = Address.init(rawValue: addressString!) else { return nil }
                    self = .random(address)
                    break
            case "anonymous":
                    self = .anonymous
                    break
            default:
                return nil
            }
        }
        
        public var description: String {
            switch self {
                
            case .public: return "public"
            case .random: return "random"
            case .anonymous: return "anonymous"
            }
        }
        
        public var device: LowEnergyWhiteListDevice {
            
            switch self {
            case .public(let address): return LowEnergyWhiteListDevice.public(address)
            case .random(let address): return LowEnergyWhiteListDevice.random(address)
            case .anonymous: return LowEnergyWhiteListDevice.anonymous
            }
        }
    }
}
