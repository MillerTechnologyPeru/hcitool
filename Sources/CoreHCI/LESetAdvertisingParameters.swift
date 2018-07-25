//
//  LESetAdvertisingParameters.swift
//  hcitool
//
//  Created by Marco Estrella on 5/3/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LESetAdvertisingParametersCommand: ArgumentableCommand {
    
    public typealias LEAdvertisingType = HCILESetAdvertisingParameters.AdvertisingType
    public typealias LEChannelMap = HCILESetAdvertisingParameters.ChannelMap
    public typealias LEFilterPolicy = HCILESetAdvertisingParameters.FilterPolicy
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergySetAdvertisingParameters
    
    public var advertisingInterval: (min: AdvertisingInterval, max: AdvertisingInterval)
    public var advertisingType: LEAdvertisingType
    public var addressType: (own: LowEnergyAddressType, direct: LowEnergyAddressType)
    public var peerAddress: Address
    public var channelMap: LEChannelMap
    public var filterPolicy: LEFilterPolicy
    
    // MARK: - Initialization
    
    public init(interval: (min: AdvertisingInterval, max: AdvertisingInterval) = (.default, .default),
                advertisingType: LEAdvertisingType = LEAdvertisingType(),
                addressType: (own: LowEnergyAddressType, direct: LowEnergyAddressType) = (.public, .public),
                peerAddress: Address = .zero,
                channelMap: LEChannelMap = .channel37,
                filterPolicy: LEFilterPolicy = LEFilterPolicy()) {
        
        self.advertisingInterval = interval
        self.advertisingType = advertisingType
        self.addressType = addressType
        self.peerAddress = peerAddress
        self.channelMap = channelMap
        self.filterPolicy = filterPolicy
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let intervalMinString = parameters.first(where: { $0.option == .advertisingIntervalMin })?.value,
            let advertisingIntervalMinRawValue = UInt16(commandLine: intervalMinString),
            let advertisingIntervalMin = AdvertisingInterval(rawValue: advertisingIntervalMinRawValue)
            else { throw CommandError.optionMissingValue(Option.advertisingIntervalMin.rawValue) }
        
        guard let intervalMaxString = parameters.first(where: { $0.option == .advertisingIntervalMax })?.value,
            let advertisingIntervalMaxRawValue = UInt16(commandLine: intervalMaxString),
            let advertisingIntervalMax = AdvertisingInterval(rawValue: advertisingIntervalMaxRawValue)
            else { throw CommandError.optionMissingValue(Option.advertisingIntervalMax.rawValue) }
        
        guard let advertisingTypeString = parameters.first(where: { $0.option == .advertisingType })?.value
            else { throw CommandError.optionMissingValue(Option.advertisingType.rawValue) }
        
        guard let advertisingType = AdvertisingType(rawValue: advertisingTypeString)
            else { throw CommandError.invalidOptionValue(option: Option.advertisingType.rawValue, value: advertisingTypeString) }
        
        guard let ownAddressTypeString = parameters.first(where: { $0.option == .ownAddressType })?.value
            else { throw CommandError.optionMissingValue(Option.ownAddressType.rawValue) }
        
        guard let ownAddressType = AddressType(rawValue: ownAddressTypeString)
            else { throw CommandError.invalidOptionValue(option: Option.ownAddressType.rawValue, value: ownAddressTypeString) }
        
        guard let peerAddressTypeString = parameters.first(where: { $0.option == .peerAddressType })?.value
            else { throw CommandError.optionMissingValue(Option.peerAddressType.rawValue) }
        
        guard let peerAddressType = AddressType(rawValue: peerAddressTypeString)
            else { throw CommandError.invalidOptionValue(option: Option.peerAddressType.rawValue, value: peerAddressTypeString) }
        
        guard let peerAddressString = parameters.first(where: { $0.option == .peerAddress })?.value,
            let peerAddress = Address(rawValue: peerAddressString)
            else { throw CommandError.optionMissingValue(Option.peerAddress.rawValue) }
        
        guard let channelMapString = parameters.first(where: { $0.option == .advertisingChannelMap })?.value
            else { throw CommandError.optionMissingValue(Option.advertisingChannelMap.rawValue) }
        
        guard let channelMap = ChannelMap(rawValue: channelMapString)
            else { throw CommandError.invalidOptionValue(option: Option.advertisingChannelMap.rawValue, value: channelMapString) }
        
        guard let filterPolicyString = parameters.first(where: { $0.option == .advertisingFilterPolicy })?.value
            else { throw CommandError.optionMissingValue(Option.advertisingFilterPolicy.rawValue) }
        
        guard let filterPolicy = FilterPolicy(rawValue: filterPolicyString)
            else { throw CommandError.invalidOptionValue(option: Option.advertisingFilterPolicy.rawValue, value: filterPolicyString) }
        
        self.advertisingInterval = (advertisingIntervalMin, advertisingIntervalMax)
        self.advertisingType = advertisingType.hciValue
        self.addressType = (ownAddressType.hciValue, peerAddressType.hciValue)
        self.peerAddress = peerAddress
        self.channelMap = channelMap.hciValue
        self.filterPolicy = filterPolicy.hciValue
    }
    
    // MARK: - Methods
    
    /// Tests Setting of Event Mask.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let setAdvertisingParametersParameter = HCILESetAdvertisingParameters(interval: advertisingInterval, advertisingType: advertisingType, ownAddressType: addressType.own, directAddress: peerAddress, channelMap: [channelMap], filterPolicy: filterPolicy)
        
        try controller.setLowEnergyAdvertisingParameters(setAdvertisingParametersParameter)
    }
}

public extension LESetAdvertisingParametersCommand {
    
    public enum Option: String, OptionProtocol {
        
        case advertisingIntervalMin     = "intervalmin"
        case advertisingIntervalMax     = "intervalmax"
        case advertisingType            = "type"
        case ownAddressType             = "ownaddresstype"
        case peerAddressType            = "peeraddresstype"
        case peerAddress                = "peeraddress"
        case advertisingChannelMap      = "channelmap"
        case advertisingFilterPolicy    = "filterpolicy"
        
        public static let all: Set<Option> = [.advertisingIntervalMin, .advertisingIntervalMax,
                                              .advertisingType, .ownAddressType,
                                              .peerAddressType, .peerAddress,
                                              .advertisingChannelMap, .advertisingFilterPolicy]
    }
}

public extension LESetAdvertisingParametersCommand {
    
    public enum AdvertisingType: String {
        
        public typealias HCIValue = HCILESetAdvertisingParameters.AdvertisingType
        
        case undirected
        
        case directed
        
        case scannable
        
        case nonConnectable     =    "nonconnectable"
        
        public var hciValue: HCIValue {
            
            switch self {
            case .undirected: return .undirected
            case .directed: return .directed
            case .scannable: return .scannable
            case .nonConnectable: return .nonConnectable
            }
        }
    }
    
    public enum ChannelMap: String {
        
        public typealias HCIValue = HCILESetAdvertisingParameters.ChannelMap
        
        case channel37
        case channel38
        case channel39
        
        public var hciValue: HCIValue {
            
            switch self {
            case .channel37: return .channel37
            case .channel38: return .channel38
            case .channel39: return .channel39
            }
        }
    }
    
    public enum FilterPolicy: String {
        
        public typealias HCIValue = HCILESetAdvertisingParameters.FilterPolicy
        
        case any
        case whiteListScan          = "whitelistscan"
        case whiteListConnect       = "whitelistconnect"
        case whiteListScanConnect   = "whitelistscanconnect"
        
        public var hciValue: HCIValue {
            
            switch self {
            case .any: return .any
            case .whiteListScan: return .whiteListScan
            case .whiteListConnect: return .whiteListConnect
            case .whiteListScanConnect: return .whiteListScanConnect
            }
        }
    }
}
