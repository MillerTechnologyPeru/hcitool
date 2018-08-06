//
//  SetConnectionEncryptionCommand.swift
//  hcitool
//
//  Created by Carlos Duclos on 8/6/18.
//
//

import Bluetooth
import Foundation

public struct SetConnectionEncryptionCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .setConnectionEncryption
    
    public var connectionHandle: UInt16
    
    public var encryption: HCISetConnectionEncryption.Encryption
    
    // MARK: - Initialization
    
    public init(connectionHandle: UInt16,
                encryption: HCISetConnectionEncryption.Encryption) {
        
        self.connectionHandle = connectionHandle
        self.encryption = encryption
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let handleString = parameters.first(where: { $0.option == .connectionHandle })?.value
            else { throw CommandError.optionMissingValue(Option.connectionHandle.rawValue) }
        
        guard let handle = UInt16(commandLine: handleString)
            else { throw CommandError.invalidOptionValue(option: Option.connectionHandle.rawValue, value: handleString) }
        
        self.connectionHandle = handle
        
        guard let encryptionString = parameters.first(where: { $0.option == .encryption })?.value
            else { throw CommandError.optionMissingValue(Option.encryption.rawValue) }
        
        guard let encryptionValue = UInt8(commandLine: encryptionString),
            let encryption = HCISetConnectionEncryption.Encryption(rawValue: encryptionValue)
            else { throw CommandError.invalidOptionValue(option: Option.encryption.rawValue, value: encryptionString) }
        
        self.encryption = encryption
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let encryptionChange = try controller.setConnectionEncryption(handle: connectionHandle,
                                                                      encryption: encryption)
        
        print("Connection Handle: \(encryptionChange.handle)")
        print("Status: \(encryptionChange.status.description)")
    }
}

public extension SetConnectionEncryptionCommand {
    
    public enum Option: String, OptionProtocol {
        
        case connectionHandle = "connectionhandle"
        case encryption = "encryption"
        
        public static let all: Set<Option> = [.connectionHandle, encryption]
    }
}
