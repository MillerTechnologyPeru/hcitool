
//
//  Command.swift
//  hcitoolPackageDescription
//
//  Created by Marco Estrella on 3/26/18.
//

import Foundation

public enum CommandType: String {
    
    // Low Energy Scan
    case leScan = "lescan"
    
    // Reads the Bluetooth controller's local name.
    case readLocalName = "readname"
    
    // Write the Bluetooth controller's local name.
    case writeLocalName = "writename"
}

public enum Command {
    
    // Low Energy Scan
    case leScan(LEScanCommand)
    
    /*
    // Reads the Bluetooth controller's local name.
    case readLocalName
    
    // Write the Bluetooth controller's local name.
    case writeLocalName(name: String)
    */
}

public protocol CommandProtocol {
    
    static var commandType: CommandType { get }
    
    init(options: [String]) throws
    
    func execute()
}

public extension Command {
    
    public init(arguments: [String]) throws {
        
        guard let commandTypeString = arguments.first
            else { throw CommandError.noCommand }
        
        guard let commandType = CommandType(rawValue: commandTypeString)
            else { throw CommandError.invalidCommandType(commandTypeString) }
        
        let commandArguments = Array(arguments.dropFirst())
        
        switch commandType {
        case .leScan:
            let commandValue = try LEScanCommand(arguments: commandArguments)
            self = .leScan(commandValue)
        case .readLocalName:
            fatalError()
        case .writeLocalName:
            fatalError()
        }
    }
}

private func parseOption <T: Option> ()

public enum CommandError: Error {
    
    /// No command specified.
    case noCommand
    
    /// Invalid command.
    case invalidCommandType(String)
    
    /// Invalid number of arguments.
    case invalidArgumentsCount(expected: Int, actual: Int)
}
