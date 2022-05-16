//
//  Argument.swift
//  
//
//  Created by Alsey Coleman Miller on 5/16/22.
//

import Foundation
import ArgumentParser
import Bluetooth
import BluetoothGAP
import BluetoothHCI

extension UUID: ExpressibleByArgument {
    
    public init?(argument: String) {
        self.init(uuidString: argument)
    }
}

extension AdvertisingInterval: ExpressibleByArgument {
    
    public init?(argument: String) {
        if argument.hasPrefix("0x") {
            let hexString = argument.replacingOccurrences(of: "0x", with: "")
            guard let hexValue = UInt16(hexString.lowercased(), radix: 16) else {
                return nil
            }
            self.init(rawValue: hexValue)
        } else {
            guard let intValue = Int(argument: argument) else {
                return nil
            }
            self.init(miliseconds: intValue)
        }
    }
}
