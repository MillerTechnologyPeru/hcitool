//
//  RequestRemoteName.swift
//  hcitool
//
//  Created by Carlos Duclos on 8/3/18.
//
//

import Foundation
import Bluetooth

public struct RequestRemoteNameCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .remoteNameRequest
    
    public var address: Address
    
    public var pageScanRepetitionMode: PageScanRepetitionMode
    
    public var clockOffset: HCIRemoteNameRequest.ClockOffset
    
    // MARK: - Initialization
    
    public init(address: Address,
                pageScanRepetitionMode: PageScanRepetitionMode,
                clockOffset: HCIRemoteNameRequest.ClockOffset) {
        
        self.address = address
        self.pageScanRepetitionMode = pageScanRepetitionMode
        self.clockOffset = clockOffset
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let addressString = parameters.first(where: { $0.option == .address })?.value
            else { throw CommandError.optionMissingValue(Option.address.rawValue) }
        
        guard let address = Address(rawValue: addressString)
            else { throw CommandError.invalidOptionValue(option: Option.address.rawValue, value: addressString) }
        
        self.address = address
        
        guard let pageScanRepetitionModeString = parameters.first(where: { $0.option == .pageScanRepetitionMode })?.value
            else { throw CommandError.optionMissingValue(Option.pageScanRepetitionMode.rawValue) }
        
        guard let pageScanRepetitionModeValue = UInt8(commandLine: pageScanRepetitionModeString)
            else { throw CommandError.invalidOptionValue(option: Option.pageScanRepetitionMode.rawValue, value: pageScanRepetitionModeString) }
        
        self.pageScanRepetitionMode = PageScanRepetitionMode(rawValue: pageScanRepetitionModeValue)
        
        guard let clockOffsetString = parameters.first(where: { $0.option == .clockOffset })?.value
            else { throw CommandError.optionMissingValue(Option.clockOffset.rawValue) }
        
        guard let clockOffsetValue = UInt16(commandLine: clockOffsetString)
            else { throw CommandError.invalidOptionValue(option: Option.clockOffset.rawValue, value: clockOffsetString) }
        
        self.clockOffset = HCIRemoteNameRequest.ClockOffset(rawValue: clockOffsetValue)
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.remoteNameRequest(address: address,
                                        pscanRepMode: pageScanRepetitionMode,
                                        clockOffset: clockOffset,
                                        foundDevice: { print($0) })
    }
}

public extension RequestRemoteNameCommand {
    
    public enum Option: String, OptionProtocol {
        
        case address = "address"
        case pageScanRepetitionMode = "pagescanrepetitionmode"
        case clockOffset = "clockoffset"
        
        public static let all: Set<Option> = [.address, .pageScanRepetitionMode, .clockOffset]
    }
}
