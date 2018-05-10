//
//  Int.swift
//  hcitool
//
//  Created by Marco Estrella on 5/7/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth

protocol CommandLineData {
    
    init?(commandLine string: String)
    
    init?(bigEndian: [UInt8])
}

protocol CommandLineInteger: CommandLineData {
    
    init?(_ string: String)
}

extension CommandLineData {
    
    init?(commandLine string: String) {
        
        if let value = Self.from(hexadecimal: string, requiresPrefix: false) {
            
            self = value
            
        } else {
            
            return nil
        }
    }
}

extension CommandLineInteger {
    
    init?(commandLine string: String) {
        
        if let value = Self.from(hexadecimal: string, requiresPrefix: false) {
            
            self = value
            
        } else if let value = Self.init(string) {
            
            self = value
            
        } else {
            
            return nil
        }
    }
}

private extension CommandLineData {
    
    static func from(hexadecimal string: String, requiresPrefix: Bool) -> Self? {
        
        let hexString: String
        
        if string.containsHexadecimalPrefix() {
            
            hexString = string.removeHexadecimalPrefix()
            
        } else {
            
            guard requiresPrefix == false
                else { return nil }
            
            hexString = string
        }
        
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
            let substring = String(characters[index ... nextLetterIndex])
            
            guard let byte = UInt8(substring, radix: 16)
                else { return nil }
            
            bytes.append(byte)
            
            index = characters.index(index, offsetBy: 2)
        }
        
        assert(bytes.count == byteCount)
        
        return Self.init(bigEndian: bytes)
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

extension UInt128: CommandLineData {
    
    init?(bigEndian bytes: [UInt8]) {
        
        guard bytes.count == 16
            else { return nil }
        
        self.init(bigEndian: UInt128(bytes: (bytes[0], bytes[1], bytes[2], bytes[3], bytes[4], bytes[5], bytes[6], bytes[7], bytes[8], bytes[9], bytes[10], bytes[11], bytes[12], bytes[13], bytes[14], bytes[15])))
    }
}
