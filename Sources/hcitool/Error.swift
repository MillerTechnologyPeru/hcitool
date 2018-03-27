//
//  Error.swift
//  hcitool
//
//  Created by Alsey Coleman Miller on 3/27/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

public enum CommandError: Error {
    
    /// Bluetooth controllers not availible.
    case bluetoothUnavailible
    
    /// No command specified.
    case noCommand
    
    /// Invalid command.
    case invalidCommandType(String)
    
    case invalidOption(String)
    
    case missingOption(String)
    
    case optionMissingValue(String)
    
    case invalidOptionValue(option: String, value: String)
}

/*
extension CommandError: CustomStringConvertible {
    
    public var description: String {
        
        switch self {
        case <#pattern#>:
            <#code#>
        default:
            <#code#>
        }
    }
}
*/
