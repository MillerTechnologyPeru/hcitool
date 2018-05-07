//
//  Int.swift
//  hcitool
//
//  Created by Marco Estrella on 5/7/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

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
