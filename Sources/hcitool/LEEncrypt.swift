//
//  LEReadRemoteFeatures .swift
//  hcitool
//
//  Created by Marco Estrella on 5/9/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

//
//  LEAddDeviceToWhiteList.swift
//  hcitool
//
//  Created by Marco Estrella on 4/28/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEEncryptCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyEncrypt
    
    public let key: UInt128
    
    public let data: UInt128
    
    // MARK: - Initialization
    
    public init(key: UInt128, data: UInt128) {
        
        self.key = key
        self.data = data
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let keyString = parameters.first(where: { $0.option == .key })?.value
            else {throw CommandError.optionMissingValue(Option.key.rawValue)}
        
        guard let keyData = keyString.data(using: .utf8),
            let key = UInt128(data: keyData)
            else { throw CommandError.invalidOptionValue(option: Option.key.rawValue, value: keyString) }
        
        guard let dataString = parameters.first(where: { $0.option == .data })?.value
            else {throw CommandError.optionMissingValue(Option.key.rawValue)}
        
        guard let dataData = dataString.data(using: .utf8),
            let data = UInt128(data: dataData)
            else { throw CommandError.invalidOptionValue(option: Option.data.rawValue, value: dataString) }
        
        self.key = key
        self.data = data
    }
    
    // MARK: - Methods
    
    /// Tests adding a device to the LE white list.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let encryptedData = try controller.lowEnergyEncrypt(key: key, data: data)
        
        let encryptedDataHexString = encryptedData.data.map{ String(format:"%02x", $0) }.joined()
        
        print(encryptedDataHexString)
    }
}

public extension LEEncryptCommand {
    
    public enum Option: String, OptionProtocol {
        
        case key
        case data
        
        public static let all: Set<Option> = [.key, .data]
    }
}


