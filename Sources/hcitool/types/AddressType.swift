//
//  AddressType.swift
//  hcitool
//
//  Created by Marco Estrella on 5/3/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public enum AddressType: String {
    
    public typealias HCIValue = LowEnergyAddressType
    
    case `public`           = "public"
    
    case random
    
    case publicIdentity     = "publicidentity"
    
    case randomIdentity     = "randomidentity"
    
    public var hciValue: HCIValue {
        
        switch self {
        case .public: return .public
        case .random: return .random
        case .publicIdentity: return .publicIdentity
        case .randomIdentity: return .randomIdentity
        }
    }
}
