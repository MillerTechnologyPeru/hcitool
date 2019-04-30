//
//  LEReceiverTest .swift
//  hcitool
//
//  Created by Marco Estrella on 5/11/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEReceiverTestCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReceiverTest
    
    public var rxChannel: LowEnergyRxChannel
    
    // MARK: - Initialization
    
    public init(rxChannel: LowEnergyRxChannel) {
        
        self.rxChannel = rxChannel
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let rxChannelString = parameters.first(where: { $0.option == .rxChannel })?.value
            else { throw CommandError.optionMissingValue(Option.rxChannel.rawValue) }
        
        guard let rxChannelUint8 = UInt8(commandLine: rxChannelString),
            let rxChannel = LowEnergyRxChannel(rawValue: rxChannelUint8)
            else { throw CommandError.invalidOptionValue(option: Option.rxChannel.rawValue, value: rxChannelString) }
        
        self.rxChannel = rxChannel
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.lowEnergyReceiverTest(rxChannel: rxChannel)
    }
}

public extension LEReceiverTestCommand {
    
    enum Option: String, OptionProtocol {
        
        case rxChannel = "rxchannel"
        
        public static let all: Set<Option> = [.rxChannel]
    }
}


