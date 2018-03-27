
//
//  Command.swift
//  hcitoolPackageDescription
//
//  Created by Marco Estrella on 3/26/18.
//

import Foundation
import Bluetooth

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

public extension Command {
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        switch self {
        case let .leScan(command): try command.execute(controller: controller)
        }
    }
}

/*
extension Command: RawRepresentable {
    
    public init?(rawValue: CommandProtocol) {
        
        if let value = rawValue as? LEScanCommand {
            
            self = .leScan(value)
        } else {
            
            return nil
        }
    }
    
    public var rawValue: CommandProtocol {
        
        switch self {
        case let .leScan(value): return value
        case let .readLocalName(value): return value
        case let .writeLocalName(value): return value
        }
    }
}*/

public protocol CommandProtocol {
    
    associatedtype Option: OptionProtocol
    
    static var commandType: CommandType { get }
    
    init(options: [Option: String]) throws
    
    func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws
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
            let option = try LEScanCommand.Option.parse(arguments: commandArguments)
            let commandValue = try LEScanCommand(options: option)
            self = .leScan(commandValue)
        case .readLocalName:
            fatalError()
        case .writeLocalName:
            fatalError()
        }
    }
}
