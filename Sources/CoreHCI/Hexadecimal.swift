//
//  Hexadecimal.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/23/18.
//
//

import Foundation

internal extension UInt8 {
    
    func toHexadecimal() -> String {
        
        var string = String(self, radix: 16)
        
        if string.utf8.count == 1 {
            
            string = "0" + string
        }
        
        return string.uppercased()
    }
}

internal extension UInt16 {
    
    func toHexadecimal() -> String {
        
        var string = String(self, radix: 16)
        
        while string.utf8.count < (MemoryLayout<UInt16>.size * 2) {
            
            // prepend zeroes
            string = "0" + string
        }
        
        return string.uppercased()
    }
}

internal extension UInt32 {
    
    func toHexadecimal() -> String {
        
        var string = String(self, radix: 16)
        
        while string.utf8.count < (MemoryLayout<UInt32>.size * 2) {
            
            // prepend zeroes
            string = "0" + string
        }
        
        return string.uppercased()
    }
}

internal extension UInt64 {
    
    func toHexadecimal() -> String {
        
        var string = String(self, radix: 16)
        
        while string.utf8.count < (MemoryLayout<UInt64>.size * 2) {
            
            // prepend zeroes
            string = "0" + string
        }
        
        return string.uppercased()
    }
}
