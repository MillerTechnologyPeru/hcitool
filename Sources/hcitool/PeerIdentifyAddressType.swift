//
//  PeerIdentifyAddressType.swift
//  hcitool
//
//  Created by Marco Estrella on 5/15/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public enum PeerIdentifyAddressType: String {
    
    public typealias HCIValue = LowEnergyPeerIdentifyAddressType
    
    case `public` = "public"
    case random
    
    public var hciValue: HCIValue {
        switch self {
            
        case .public: return .public
        case .random: return .random
        }
    }
}
