//
//  ReadLMPHandle.swift
//  hcitool
//
//  Created by Carlos Duclos on 8/9/18.
//
//

import Foundation

import Bluetooth
import Foundation

public struct ReadLMPHandleCommand: ArgumentableCommand {
    
    public typealias PacketType = HCICreateConnection.PacketType
    public typealias ClockOffset = HCICreateConnection.ClockOffset
    public typealias AllowRoleSwitch = HCICreateConnection.AllowRoleSwitch
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .readLMPHandle
    
    public let address: Address
    
    public let packetType: UInt16
    
    public let pageScanRepetitionMode: PageScanRepetitionMode
    
    public let clockOffset: BitMaskOptionSet<ClockOffset>
    
    public let allowRoleSwitch: AllowRoleSwitch
    
    // MARK: - Initialization
    
    public init(address: Address,
                packetType: UInt16,
                pageScanRepetitionMode: PageScanRepetitionMode,
                clockOffset: BitMaskOptionSet<ClockOffset>,
                allowRoleSwitch: AllowRoleSwitch) {
        
        self.address = address
        self.packetType = packetType
        self.pageScanRepetitionMode = pageScanRepetitionMode
        self.clockOffset = clockOffset
        self.allowRoleSwitch = allowRoleSwitch
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let addressString = parameters.first(where: { $0.option == .address })?.value
            else { throw CommandError.optionMissingValue(Option.address.rawValue) }
        
        guard let address = Address(rawValue: addressString)
            else { throw CommandError.invalidOptionValue(option: Option.address.rawValue, value: addressString) }
        
        self.address = address
        
        guard let packetTypeString = parameters.first(where: { $0.option == .packetType })?.value
            else { throw CommandError.optionMissingValue(Option.packetType.rawValue) }
        
        guard let packetTypeValue = UInt16(commandLine: packetTypeString)
            else { throw CommandError.invalidOptionValue(option: Option.packetType.rawValue, value: packetTypeString) }
        
        self.packetType = packetTypeValue
        
        guard let pageScanRepetitionModeString = parameters.first(where: { $0.option == .pageScanRepetitionMode })?.value
            else { throw CommandError.optionMissingValue(Option.pageScanRepetitionMode.rawValue) }
        
        guard let pageScanRepetitionModeValue = UInt8(commandLine: pageScanRepetitionModeString)
            else { throw CommandError.invalidOptionValue(option: Option.pageScanRepetitionMode.rawValue, value: pageScanRepetitionModeString) }
        
        self.pageScanRepetitionMode = PageScanRepetitionMode(rawValue: pageScanRepetitionModeValue)
        
        guard let clockOffsetString = parameters.first(where: { $0.option == .clockOffset })?.value
            else { throw CommandError.optionMissingValue(Option.clockOffset.rawValue) }
        
        guard let clockOffsetValue = UInt16(commandLine: clockOffsetString)
            else { throw CommandError.invalidOptionValue(option: Option.clockOffset.rawValue, value: clockOffsetString) }
        
        self.clockOffset = BitMaskOptionSet<ClockOffset>(rawValue: clockOffsetValue)
        
        guard let allowRoleSwitchString = parameters.first(where: { $0.option == .allowRoleSwitch })?.value
            else { throw CommandError.optionMissingValue(Option.allowRoleSwitch.rawValue) }
        
        guard let allowRoleSwitchValue = UInt8(commandLine: allowRoleSwitchString),
            let allowRoleSwitch = AllowRoleSwitch(rawValue: allowRoleSwitchValue)
            else { throw CommandError.invalidOptionValue(option: Option.allowRoleSwitch.rawValue, value: allowRoleSwitchString) }
        
        self.allowRoleSwitch = allowRoleSwitch
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let connectionComplete = try controller.createConnection(address: address,
                                                                 packetType: packetType,
                                                                 pageScanRepetitionMode: pageScanRepetitionMode,
                                                                 clockOffset: clockOffset,
                                                                 allowRoleSwitch: allowRoleSwitch,
                                                                 timeout: 5000)
        
        let offset = try controller.authenticationRequested(handle: connectionComplete.handle)
        
        print("Clock offset = \(offset.rawValue.toHexadecimal())")
    }
}

public extension ReadLMPHandleCommand {
    
    public enum Option: String, OptionProtocol {
        
        case address = "address"
        case packetType = "packettype"
        case pageScanRepetitionMode = "pagescanrepetitionmode"
        case clockOffset = "clockoffset"
        case allowRoleSwitch = "allowroleswitch"
        
        public static let all: Set<Option> = [.address, .packetType, .pageScanRepetitionMode, .clockOffset, .allowRoleSwitch]
    }
}
