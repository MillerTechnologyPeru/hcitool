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
    
    init?(_ text: String, radix: Int)
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
            
        } else if let value = Self.init(string, radix: 10) {
            
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
    
    func toHexadecimalString() -> String {
        return self.data.map{ String(format:"%02x", $0) }.joined()
    }
    
}

extension UInt512: CommandLineData {
    
    init?(bigEndian bytes: [UInt8]) {
        
        guard bytes.count == 64
            else { return nil }
        
        self.init(bigEndian: UInt512(bytes: (bytes[0], bytes[1], bytes[2], bytes[3], bytes[4], bytes[5], bytes[6], bytes[7], bytes[8], bytes[9], bytes[10], bytes[11], bytes[12], bytes[13], bytes[14], bytes[15], bytes[16], bytes[17], bytes[18], bytes[19], bytes[20], bytes[21], bytes[22], bytes[23], bytes[24], bytes[25], bytes[26], bytes[27], bytes[28], bytes[29], bytes[30], bytes[31], bytes[32], bytes[33], bytes[34], bytes[35], bytes[36], bytes[37], bytes[38], bytes[39], bytes[40], bytes[41], bytes[42], bytes[43], bytes[44], bytes[45], bytes[46], bytes[47], bytes[48], bytes[49], bytes[50], bytes[51], bytes[52], bytes[53], bytes[54], bytes[55], bytes[56], bytes[57], bytes[58], bytes[59], bytes[60], bytes[61], bytes[62], bytes[63])))
    }
    
    func toHexadecimalString() -> String {
        return self.data.map{ String(format:"%02x", $0) }.joined()
    }
    
}


internal extension UInt16 {
    
    /// Initializes value from two bytes.
    init(bytes: (UInt8, UInt8)) {
        
        self = unsafeBitCast(bytes, to: UInt16.self)
    }
    
    /// Converts to two bytes.
    var bytes: (UInt8, UInt8) {
        
        return unsafeBitCast(self, to: (UInt8, UInt8).self)
    }
}

internal extension UInt32 {
    
    /// Initializes value from four bytes.
    init(bytes: (UInt8, UInt8, UInt8, UInt8)) {
        
        self = unsafeBitCast(bytes, to: UInt32.self)
    }
    
    /// Converts to four bytes.
    var bytes: (UInt8, UInt8, UInt8, UInt8) {
        
        return unsafeBitCast(self, to: (UInt8, UInt8, UInt8, UInt8).self)
    }
}

internal extension UInt64 {
    
    /// Initializes value from four bytes.
    init(bytes: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)) {
        
        self = unsafeBitCast(bytes, to: UInt64.self)
    }
    
    /// Converts to eight bytes.
    var bytes: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8) {
        
        return unsafeBitCast(self, to: (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8).self)
    }
}
