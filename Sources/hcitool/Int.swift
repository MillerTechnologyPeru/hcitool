//
//  Int.swift
//  hcitool
//
//  Created by Marco Estrella on 5/7/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//
import Bluetooth

protocol CommandLineInteger {
    
    init?(_ string: String)
    
    init?(_ string: String, radix: Int)
    
    init?(bigEndian: [UInt8])
}

extension CommandLineInteger {
    
    init?(commandLine string: String) {
        
        if string.hasPrefix("0x") {
            
            let hexString = string.removeHexadecimalPrefix()
            let characters = hexString.characters
            
            let byteCount = characters.count / 2
            var bytes = [UInt8]()
            bytes.reserveCapacity(byteCount)
            
            var index = characters.startIndex
            
            while index < characters.endIndex {
                
                let nextLetterIndex = characters.index(index, offsetBy: 1)
                
                guard nextLetterIndex < characters.endIndex
                    else { return nil }
                
                // 2 letter hex string
                let substring = characters[index ... nextLetterIndex]
                
                guard let byte = UInt8(String(substring), radix: 16)
                    else { return nil }
                
                bytes.append(byte)
                
                index = characters.index(index, offsetBy: 2)
            }
            
            assert(bytes.count == byteCount)
            
            self.init(bigEndian: bytes)
            
        } else {
            
            self.init(string)
        }
    }
}


// MARK: - Protocol Conformance

extension UInt8: CommandLineInteger {
    
    init?(bigEndian bytes: [UInt8]) {
        
        guard bytes.count == 1
            else { return nil }
        
        self = bytes[0]
    }
}

extension UInt16: CommandLineInteger {
    
    init?(bigEndian bytes: [UInt8]) {
        
        guard bytes.count == 2
            else { return nil }
        
        self.init(bigEndian: UInt16(bytes: (bytes[0], bytes[1])))
    }
}

extension UInt32: CommandLineInteger {
    
    init?(bigEndian bytes: [UInt8]) {
        
        guard bytes.count == 4
            else { return nil }
        
        self.init(bigEndian: UInt32(bytes: (bytes[0], bytes[1], bytes[2], bytes[3])))
    }
}

extension UInt64: CommandLineInteger {
    
    init?(bigEndian bytes: [UInt8]) {
        
        guard bytes.count == 8
            else { return nil }
        
        self.init(bigEndian: UInt64(bytes: (bytes[0], bytes[1], bytes[2], bytes[3], bytes[4], bytes[5], bytes[6], bytes[7])))
    }
}

extension UInt128: CommandLineInteger {
    
    init?(_ string: String){
        
        let radix = UInt128._determineRadixFromString(string)
        let inputString = radix == 10 ? string : String(string.dropFirst(2))
    
        self.init(inputString, radix: radix)
    }
    
    init?(_ string: String, radix: Int){
        
    }
    
    internal static func _determineRadixFromString(_ string: String) -> Int {
        switch string.prefix(2) {
        case "0b": return 2
        case "0o": return 8
        case "0x": return 16
        default: return 10
        }
    }
    
    init?(bigEndian bytes: [UInt8]) {
        
        guard bytes.count == 16
            else { return nil }
        
        self.init(bigEndian: UInt128(bytes: (bytes[0], bytes[1], bytes[2], bytes[3], bytes[4], bytes[5], bytes[6], bytes[7], bytes[8], bytes[9], bytes[10], bytes[11], bytes[12], bytes[13], bytes[14], bytes[15])))
    }
}
