//
//  String.swift
//  hcitool
//
//  Created by Marco Estrella on 5/4/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Foundation

extension String {
    
    func removeHexadecimalPrefix() -> String {
        
        let startIndex = self.index(self.startIndex, offsetBy: 2)
        
        if self.count > 2 && self[..<startIndex] == "0x" {
            
            return String(self[startIndex...])
        }
        return self
    }
}
