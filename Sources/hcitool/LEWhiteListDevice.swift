//
//  LEWhiteListDevice.swift
//  hcitool
//
//  Created by Alsey Coleman Miller on 4/28/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth

/// LE White List Address Type
public enum LEWhiteListAddressType: String {
    
    case `public` = "public"
    case random
    case anonymous
}

/// LE White List Device Entry
public enum LEWhiteListDevice {
    
    public typealias HCIValue = BluetoothHCI.LowEnergyWhiteListDevice
    
    case `public`(BluetoothAddress)
    case random(BluetoothAddress) 
    case anonymous
    
    public init?(addressType: LEWhiteListAddressType, address: BluetoothAddress? = nil) {
        
        switch addressType {
            
        case .public:
            
            guard let address = address else { return nil }
            self = .public(address)
            
        case .random:
            
            guard let address = address else { return nil }
            self = .random(address)
            
        case .anonymous:
            self = .anonymous
        }
    }
    
    public var hciValue: HCIValue {
        
        switch self {
        case let .public(address): return .public(address)
        case let .random(address): return .random(address)
        case .anonymous: return .anonymous
        }
    }
}
