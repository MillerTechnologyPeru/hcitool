//
//  Option.swift
//  hcitool
//
//  Created by Alsey Coleman Miller on 3/27/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Foundation

public protocol OptionProtocol: RawRepresentable, Hashable {
    
    init?(rawValue: String)
    
    var rawValue: String { get }
    
    static var all: Set<Self> { get }
}

public extension OptionProtocol {
    
    static func parse(arguments: [String]) throws -> [Self: String] {
        
        guard arguments.isEmpty == false
            else { return [:] }
        
        var options = [Self: String](minimumCapacity: all.count)
        
        var index = 0
        
        while index < arguments.count {
            
            let optionString = arguments[index]
            
            index += 1
            
            let optionRawValue = String(optionString.characters.drop(while: { $0 == "-" }))
            
            guard let option = Self.init(rawValue: optionRawValue)
                else { throw CommandError.invalidOption(optionRawValue) }
            
            guard index < arguments.count
                else { throw CommandError.optionMissingValue(option.rawValue) }
            
            let argumentValue = arguments[index]
            
            index += 1
            
            options[option] = argumentValue
        }
        
        return options
    }
}
