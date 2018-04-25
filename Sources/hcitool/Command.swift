
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
    
    // iBeacon
    case iBeacon = "ibeacon"
    
    // Reads the Bluetooth controller's local name.
    case readLocalName = "readname"
    
    // Write the Bluetooth controller's local name.
    case writeLocalName = "writename"
    
    // Set the Bluetooth controller's random address
    case setRandomAddress = "setrandomaddress"
    
    // Clear the White List stored in the Controller.
    case clearWhiteList = "clearwhitelist"
    
    //  Cancel the LE_Create_Connection or LE_Extended_Create_Connection commands.
    case createConnectionCancel = "createconnectioncancel"
    
    case readLocalSupportedFeatures = "readlocalsupportedfeatures"
}

public enum Command {
    
    // Low Energy Scan
    case leScan(LEScanCommand)
    
    case iBeacon(iBeaconCommand)
    
    // Reads the Bluetooth controller's local name.
    case readLocalName
    
    // Write the Bluetooth controller's local name.
    case writeLocalName(WriteLocalNameCommand)
    
    // Set the Bluetooth controller's random address
    case setRandomAddress(SetRandomAddressCommand)
    
    // Clear the White List stored in the Controller.
    case clearWhiteList
    
    //  Cancel the LE_Create_Connection or LE_Extended_Create_Connection commands.
    case createConnectionCancel
    
    // Requests the list of the supported LE features for the Controller.
    case readLocalSupportedFeatures
}

public extension Command {
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        switch self {
        case let .leScan(command): try command.execute(controller: controller)
        case .readLocalName: try ReadLocalNameCommand().execute(controller: controller)
        case let .writeLocalName(command): try command.execute(controller: controller)
        case let .iBeacon(command): try command.execute(controller: controller)
        case let .setRandomAddress(command): try command.execute(controller: controller)
        case .clearWhiteList: try ClearWhiteListCommand().execute(controller: controller)
        case .createConnectionCancel: try CreateConnectionCancelCommand().execute(controller: controller)
        case .readLocalSupportedFeatures: try ReadLocalSupportedFeaturesCommand().execute(controller: controller)
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
    
    static var commandType: CommandType { get }
    
    func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws
}

public protocol ArgumentableCommand: CommandProtocol {
    
    associatedtype Option: OptionProtocol

    init(options: [Option: String]) throws
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
            let options = try LEScanCommand.Option.parse(arguments: commandArguments)
            let commandValue = try LEScanCommand(options: options)
            self = .leScan(commandValue)
        case .readLocalName:
            self = .readLocalName
        case .writeLocalName:
            let options = try WriteLocalNameCommand.Option.parse(arguments: commandArguments)
            let commandValue = try WriteLocalNameCommand(options: options)
            self = .writeLocalName(commandValue)
        case .iBeacon:
            let options = try iBeaconCommand.Option.parse(arguments: commandArguments)
            let commandValue = try iBeaconCommand(options: options)
            self = .iBeacon(commandValue)
        case .setRandomAddress:
            let options = try SetRandomAddressCommand.Option.parse(arguments: commandArguments)
            let commandValue = try SetRandomAddressCommand(options: options)
            self = .setRandomAddress(commandValue)
        case .clearWhiteList:
            self = .clearWhiteList
        case .createConnectionCancel:
            self = .createConnectionCancel
        case .readLocalSupportedFeatures:
            self = .readLocalSupportedFeatures
        }
    }
}
