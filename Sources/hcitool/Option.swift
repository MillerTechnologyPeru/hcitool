//
//  Option.swift
//  hcitool
//
//  Created by Alsey Coleman Miller on 3/27/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import Foundation

public protocol OptionProtocol: RawRepresentable, Hashable {
    
    init?(rawValue: String)
    
    var rawValue: String { get }
    
    static var all: Set<Self> { get }
}

public struct Parameter <Option: OptionProtocol> {
    
    public var option: Option
    
    public var value: String
}

public extension Parameter {
    
    static func parse(arguments: [String])  throws -> [Parameter] {
        
        guard arguments.isEmpty == false
            else { return [] }
        
        var argumentValues = [Parameter]()
        argumentValues.reserveCapacity(arguments.count / 2)
        
        var index = 0
        
        while index < arguments.count {
            
            let optionString = arguments[index]
            
            index += 1
            
            let optionRawValue = String(optionString.characters.drop(while: { $0 == "-" }))
            
            guard let option = Option.init(rawValue: optionRawValue)
                else { throw CommandError.invalidOption(optionRawValue) }
            
            guard index < arguments.count
                else { throw CommandError.optionMissingValue(option.rawValue) }
            
            let argumentValue = arguments[index]
            
            index += 1
            
            argumentValues.append(Parameter(option: option, value: argumentValue))
        }
        
        return argumentValues
    }
}
