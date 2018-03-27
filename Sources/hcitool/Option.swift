//
//  Option.swift
//  hcitool
//
//  Created by Alsey Coleman Miller on 3/27/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Foundation

public struct Option {
    
    public let letter: String
    
    public let name: String
    
    public let description: String
    
    public func value(in arguments: [String]) -> String? {
        
        fatalError()
    }
}
