//
//  LEReadPeerResolvableAddress.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/24/18.
//
//

import Bluetooth
import Foundation

public struct LEReadPeerResolvableAddressCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReadPeerResolvableAddress
    
    public let peerIdentifyAddressType: LowEnergyPeerIdentifyAddressType
    
    public let peerIdentifyAddress: UInt64
    
    // MARK: - Initialization
    
    public init(peerIdentifyAddressType: LowEnergyPeerIdentifyAddressType, peerIdentifyAddress: UInt64) {
        
        self.peerIdentifyAddressType = peerIdentifyAddressType
        self.peerIdentifyAddress = peerIdentifyAddress
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let peerIdentifyAddressTypeString = parameters.first(where: { $0.option == .peerIdentifyAddressType })?.value
            else { throw CommandError.optionMissingValue(Option.peerIdentifyAddressType.rawValue) }
        
        guard let peerIdentifyAddressType = PeerIdentifyAddressType(rawValue: peerIdentifyAddressTypeString)
            else { throw CommandError.invalidOptionValue(option: Option.peerIdentifyAddressType.rawValue, value: peerIdentifyAddressTypeString) }
        
        guard let peerIdentifyAddressString = parameters.first(where:{ $0.option == .peerIdentifyAddress})?.value
            else { throw CommandError.optionMissingValue(Option.peerIdentifyAddress.rawValue) }
        
        guard let peerIdentifyAddress = UInt64(commandLine: peerIdentifyAddressString)
            else { throw CommandError.invalidOptionValue(option: Option.peerIdentifyAddress.rawValue, value: peerIdentifyAddressString) }
        
        self.peerIdentifyAddressType = peerIdentifyAddressType.hciValue
        self.peerIdentifyAddress = peerIdentifyAddress
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let privateAddress = try controller.lowEnergyReadPeerResolvableAddress(peerIdentifyAddressType: peerIdentifyAddressType,
                                                                               peerIdentifyAddress: peerIdentifyAddress)
        
        print("Private resolvable address = ", privateAddress)
    }
}

public extension LEReadPeerResolvableAddressCommand {
    
    public enum Option: String, OptionProtocol {
        
        case peerIdentifyAddressType    = "peeridentifyaddresstype"
        case peerIdentifyAddress        = "peeridentifyaddress"
        
        public static let all: Set<Option> = [.peerIdentifyAddressType, .peerIdentifyAddress]
    }
}
