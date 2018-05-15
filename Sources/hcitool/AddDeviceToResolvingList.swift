//
//  AddDeviceToResolvingList.swift
//  hcitool
//
//  Created by Marco Estrella on 5/15/18.
//  Copyright © 2018 Pure Swift. All rights reserved.

import Bluetooth
import Foundation

public struct LEAddDeviceToResolvingListCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyAddDeviceToResolvingList
    
    public let peerIdentifyAddressType: LowEnergyPeerIdentifyAddressType
    
    public let peerIdentifyAddress: UInt64
    
    public let peerIrk: UInt128
    
    public let localIrk: UInt128
    
    // MARK: - Initialization
    
    public init(peerIdentifyAddressType: LowEnergyPeerIdentifyAddressType, peerIdentifyAddress: UInt64, peerIrk: UInt128, localIrk: UInt128) {
        
        self.peerIdentifyAddressType = peerIdentifyAddressType
        self.peerIdentifyAddress = peerIdentifyAddress
        self.peerIrk = peerIrk
        self.localIrk = localIrk
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
        
        guard let peerIrkString = parameters.first(where:{ $0.option == .peerIrk})?.value
            else { throw CommandError.optionMissingValue(Option.peerIrk.rawValue) }
        
        guard let peerIrk = UInt128(commandLine: peerIrkString)
            else { throw CommandError.invalidOptionValue(option: Option.peerIrk.rawValue, value: peerIrkString) }
        
        guard let localIrkString = parameters.first(where:{ $0.option == .localIrk})?.value
            else { throw CommandError.optionMissingValue(Option.localIrk.rawValue) }
        
        guard let localIrk = UInt128(commandLine: localIrkString)
            else { throw CommandError.invalidOptionValue(option: Option.localIrk.rawValue, value: localIrkString) }
        
        self.peerIdentifyAddressType = peerIdentifyAddressType.hciValue
        self.peerIdentifyAddress = peerIdentifyAddress
        self.peerIrk = peerIrk
        self.localIrk = localIrk
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.lowEnergyAddDeviceToResolvingList(peerIdentifyAddressType: peerIdentifyAddressType,
                                                         peerIdentifyAddress: peerIdentifyAddress,
                                                         peerIrk: peerIrk,
                                                         localIrk: localIrk)
    }
}

public extension LEAddDeviceToResolvingListCommand {
    
    public enum PeerIdentifyAddressType: String {
        
        public typealias HCIValue = LowEnergyPeerIdentifyAddressType
        
        case publicIdentifyAddress = "public"
        case randomIdentifyAddress = "random"
        
        public var hciValue: HCIValue {
            switch self {
                
            case .publicIdentifyAddress: return .publicIdentifyAddress
            case .randomIdentifyAddress: return .randomIdentifyAddress
            }
        }
    }
}

public extension LEAddDeviceToResolvingListCommand {
    
    public enum Option: String, OptionProtocol {
        
        case peerIdentifyAddressType    = "peeridentifyaddresstype"
        case peerIdentifyAddress        = "peeridentifyaddress"
        case peerIrk                    = "peerirk"
        case localIrk               = "localirk"
        
        public static let all: Set<Option> = [.peerIdentifyAddressType, .peerIdentifyAddress, .peerIrk, .localIrk]
    }
}




