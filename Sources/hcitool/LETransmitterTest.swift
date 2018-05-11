//
//  LETransmitterTest.swift
//  hcitool
//
//  Created by Marco Estrella on 5/11/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LETransmitterTestCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyTransmitterTest
    
    public var txChannel: LowEnergyTxChannel
    
    public var lengthOfTestData: UInt8
    
    public var packetPayload: LowEnergyPacketPayload
    
    // MARK: - Initialization
    
    public init(txChannel: LowEnergyTxChannel,
                lengthOfTestData: UInt8,
                packetPayload: LowEnergyPacketPayload) {
        
        self.txChannel = txChannel
        self.lengthOfTestData = lengthOfTestData
        self.packetPayload = packetPayload
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let txChannelString = parameters.first(where: { $0.option == .txChannel })?.value
            else { throw CommandError.optionMissingValue(Option.txChannel.rawValue) }
        
        guard let txChannelUint8 = UInt8(commandLine: txChannelString),
            let txChannel = LowEnergyTxChannel(rawValue: txChannelUint8)
            else { throw CommandError.invalidOptionValue(option: Option.txChannel.rawValue, value: txChannelString) }
        
        guard let lengthString = parameters.first(where: { $0.option == .length})?.value
            else { throw CommandError.optionMissingValue(Option.length.rawValue) }
        
        guard let length = UInt8(commandLine: txChannelString)
            else { throw CommandError.invalidOptionValue(option: Option.length.rawValue, value: lengthString) }
        
        guard let payloadString = parameters.first(where: { $0.option == .payload })?.value
            else { throw CommandError.optionMissingValue(Option.payload.rawValue) }
        
        guard let payloadUint8 = UInt8(commandLine: payloadString),
            let packetPayload = LowEnergyPacketPayload(rawValue: payloadUint8)
            else { throw CommandError.invalidOptionValue(option: Option.payload.rawValue, value: txChannelString) }
        
        self.txChannel = txChannel
        self.lengthOfTestData = length
        self.packetPayload = packetPayload
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.lowEnergyTransmitterTest(txChannel: txChannel, lengthOfTestData: lengthOfTestData, packetPayload: packetPayload)
    }
}

public extension LETransmitterTestCommand {
    
    public enum Option: String, OptionProtocol {
        
        case txChannel = "txchannel"
        case length
        case payload
        
        public static let all: Set<Option> = [.txChannel, .length, .payload]
    }
}



