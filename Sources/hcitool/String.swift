//
//  String.swift
//  hcitool
//
//  Created by Marco Estrella on 5/4/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth

extension String {
    
    static var hexadecimalPrefix: String { return "0x" }
    
    func containsHexadecimalPrefix() -> Bool {
        
        return contains(String.hexadecimalPrefix)
    }
    
    func removeHexadecimalPrefix() -> String {
        
        guard contains(String.hexadecimalPrefix)
            else { return self }
        
        let suffixIndex = self.index(self.startIndex, offsetBy: 2)
        
        return String(suffix(from: suffixIndex))
    }
}
