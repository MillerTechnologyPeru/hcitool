//
//  LEScan.swift
//  hcitool
//
//  Created by Marco Estrella on 3/26/18.
//

#if os(Linux)
import BluetoothLinux
#elseif os(macOS)
import BluetoothDarwin
import IOBluetooth
#endif

import Bluetooth
import Foundation

public struct LEScanCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyScan
    
    public var duration: TimeInterval
    
    public var filterDuplicates: Bool
    
    public var scanType: ScanType
    
    public var interval: LowEnergyScanTimeInterval
    
    public var window: LowEnergyScanTimeInterval
    
    public var addressType: AddressType
    
    public var filterPolicy: FilterPolicy
    
    // MARK: - Initialization
    
    public static let `default` = LEScanCommand()
    
    public init(duration: TimeInterval = 10.0,
                filterDuplicates: Bool = true,
                scanType: ScanType = .active,
                interval: LowEnergyScanTimeInterval = LowEnergyScanTimeInterval(rawValue: 0x01E0)!,
                window: LowEnergyScanTimeInterval = LowEnergyScanTimeInterval(rawValue: 0x0030)!,
                addressType: AddressType = .public,
                filterPolicy: FilterPolicy = .accept) {
        
        self.duration = duration
        self.filterDuplicates = filterDuplicates
        self.scanType = scanType
        self.interval = interval
        self.window = window
        self.addressType = addressType
        self.filterPolicy = filterPolicy
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        if let durationString = parameters.first(where: { $0.option == .duration })?.value {
            
            guard let duration = TimeInterval(durationString)
                else { throw CommandError.invalidOptionValue(option: Option.duration.rawValue, value: durationString) }
            
            self.duration = duration
            
        } else {
            
            self.duration = type(of: self).default.duration
        }
        
        if let stringValue = parameters.first(where: { $0.option == .filterDuplicates })?.value {
            
            guard let value = CommandLineBool(rawValue: stringValue)
                else { throw CommandError.invalidOptionValue(option: Option.filterDuplicates.rawValue, value: stringValue) }
            
            self.filterDuplicates = value.boolValue
            
        } else {
            
            self.filterDuplicates = type(of: self).default.filterDuplicates
        }
        
        if let stringValue = parameters.first(where: { $0.option == .scanType })?.value {
            
            guard let value = ScanType(rawValue: stringValue)
                else { throw CommandError.invalidOptionValue(option: Option.scanType.rawValue, value: stringValue) }
            
            self.scanType = value
            
        } else {
            
            self.scanType = type(of: self).default.scanType
        }
        
        if let stringValue = parameters.first(where: { $0.option == .interval })?.value {
            
            guard let rawValue = UInt16(stringValue),
                let value = LowEnergyScanTimeInterval(rawValue: rawValue)
                else { throw CommandError.invalidOptionValue(option: Option.interval.rawValue, value: stringValue) }
            
            self.interval = value
            
        } else {
            
            self.interval = type(of: self).default.interval
        }
        
        if let stringValue = parameters.first(where: { $0.option == .window })?.value {
            
            guard let rawValue = UInt16(stringValue),
                let value = LowEnergyScanTimeInterval(rawValue: rawValue)
                else { throw CommandError.invalidOptionValue(option: Option.window.rawValue, value: stringValue) }
            
            self.window = value
            
        } else {
            
            self.window = type(of: self).default.window
        }
        
        if let stringValue = parameters.first(where: { $0.option == .addressType })?.value {
            
            guard let value = AddressType(rawValue: stringValue)
                else { throw CommandError.invalidOptionValue(option: Option.addressType.rawValue, value: stringValue) }
            
            self.addressType = value
            
        } else {
            
            self.addressType = type(of: self).default.addressType
        }
        
        if let stringValue = parameters.first(where: { $0.option == .filterPolicy })?.value {
            
            guard let value = FilterPolicy(rawValue: stringValue)
                else { throw CommandError.invalidOptionValue(option: Option.filterPolicy.rawValue, value: stringValue) }
            
            self.filterPolicy = value
            
        } else {
            
            self.filterPolicy = type(of: self).default.filterPolicy
        }
    }
    
    // MARK: - Methods
    
    /// Tests the Scanning functionality.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        print("Scanning for \(duration) seconds...")
        
        let endDate = Date() + duration
        
        let parameters = HCILESetScanParameters(type: scanType.hciValue,
                                                interval: interval,
                                                window: window,
                                                addressType: addressType.hciValue,
                                                filterPolicy: filterPolicy.hciValue)
        
        var decoder = GAPDataDecoder()
        decoder.ignoreUnknownType = true
        
        try controller.lowEnergyScan(parameters: parameters, shouldContinue: { Date() < endDate }) {
            print("Address:", $0.address, "(\($0.addressType))")
            print("RSSI:", $0.rssi)
            print("Event:", $0.event)
            print("Data:", $0.responseData)
            (try? decoder.decode($0.responseData))?.forEach {
                print(type(of: $0).dataType.name ?? type(of: $0).dataType.description, $0)
            }
        }
    }
}

public extension LEScanCommand {
    
    public enum Option: String, OptionProtocol {
        
        case duration
        case filterDuplicates = "filterduplicates"
        case scanType = "scantype"
        case interval
        case window
        case addressType = "addresstype"
        case filterPolicy = "filterpolicy"
        
        public static let all: Set<Option> = [.duration,
                                              .filterDuplicates,
                                              .scanType,
                                              .interval,
                                              .window,
                                              .addressType,
                                              .filterPolicy]
    }
}

public extension LEScanCommand {
    
    public enum ScanType: String {
        
        public typealias HCIValue = HCILESetScanParameters.ScanType
        
        case passive
        case active
        
        public var hciValue: HCIValue {
            switch self {
            case .passive: return .passive
            case .active: return .active
            }
        }
    }
    
    public enum AddressType: String {
        
        public typealias HCIValue = LowEnergyAddressType
        
        /// Public Device Address
        case `public` = "public"
        
        /// Random Device Address
        case random
        
        /// Public Identity Address (Corresponds to peer’s Resolvable Private Address).
        ///
        /// This value shall only be used by the Host if either the Host or the
        /// Controller does not support the LE Set Privacy Mode command.
        ///
        /// - Note: Requires Bluetooth 5.0
        case publicIdentity = "publicidentity"
        
        /// Random (static) Identity Address (Corresponds to peer’s Resolvable Private Address).
        ///
        /// This value shall only be used by a Host if either the Host or the Controller does
        /// not support the LE Set Privacy Mode command.
        case randomIdentity = "randomidentity"
        
        public init() { self = .public }
        
        public var hciValue: HCIValue {
            
            switch self {
            case .public: return .public
            case .random: return .random
            case .publicIdentity: return .publicIdentity
            case .randomIdentity: return .randomIdentity
            }
        }
    }
    
    public enum FilterPolicy: String {
        
        public typealias HCIValue = HCILESetScanParameters.FilterPolicy
        
        /// Accept all advertisement packets (default).
        ///
        /// Directed advertising packets which are not addressed for this device shall be ignored.
        case accept
        
        /// Ignore advertisement packets from devices not in the White List Only.
        ///
        /// Directed advertising packets which are not addressed for this device shall be ignored.
        case ignore
        
        public var hciValue: HCIValue {
            
            switch self {
            case .accept: return .accept
            case .ignore: return .ignore
            }
        }
    }
}
