//
//  LEReadLocalP256PublicKey.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/23/18.
//
//

import Bluetooth
import Foundation

public struct LEReadLocalP256PublicKeyCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReadLocalP256PublicKey
    
    public var remoteP256PublicKey: UInt512
    
    // MARK: - Initializers
    
    public init(remoteP256PublicKey: UInt512) {
        
        self.remoteP256PublicKey = remoteP256PublicKey
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let remoteP256PublicKeyString = parameters.first(where: { $0.option == .remoteP256PublicKey })?.value
            else { throw CommandError.optionMissingValue(Option.remoteP256PublicKey.rawValue) }
        
        guard let remoteP256PublicKey = UInt512(commandLine: remoteP256PublicKeyString)
            else { throw CommandError.invalidOptionValue(option: Option.remoteP256PublicKey.rawValue, value: remoteP256PublicKeyString) }
        
        self.remoteP256PublicKey = remoteP256PublicKey
    }
    
    // MARK: - Methods
    
    public func execute<Controller>(controller: Controller) throws where Controller : BluetoothHostControllerInterface {
        
        let localPublicKey = try controller.lowEnergyReadLocalP256PublicKey()
        
        print("Public key = ", localPublicKey.description)
    }
}

public extension LEReadLocalP256PublicKeyCommand {
    
    public enum Option: String, OptionProtocol {
        
        case remoteP256PublicKey = "remotep256publickey"
        
        public static let all: Set<Option> = [.remoteP256PublicKey]
    }
}
