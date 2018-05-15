//
//  RemoveDeviceFromResolvingList
//  hcitool
//
//  Created by Marco Estrella on 5/15/18.
//  Copyright © 2018 Pure Swift. All rights reserved.

import Bluetooth
import Foundation

public struct LERemoveDeviceFromResolvingListCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyAddDeviceToResolvingList
    
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
        
        try controller.lowEnergyRemoveDeviceFromResolvingList(peerIdentifyAddressType: peerIdentifyAddressType,
                                                              peerIdentifyAddress: peerIdentifyAddress)
    }
}

public extension LERemoveDeviceFromResolvingListCommand {
    
    public enum Option: String, OptionProtocol {
        
        case peerIdentifyAddressType    = "peeridentifyaddresstype"
        case peerIdentifyAddress        = "peeridentifyaddress"
        case peerIrk                    = "peerirk"
        case localIrk               = "localirk"
        
        public static let all: Set<Option> = [.peerIdentifyAddressType, .peerIdentifyAddress, .peerIrk, .localIrk]
    }
}





