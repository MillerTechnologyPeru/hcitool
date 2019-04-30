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

public struct LEReadRemoteFeaturesCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReadRemoteFeatures
    
    public var handle: UInt16
    
    // MARK: - Initialization
    
    public init(handle: UInt16) {
        
        self.handle = handle
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let handleString = parameters.first(where: { $0.option == .handle })?.value,
            let handle = UInt16.init(commandLine: handleString)
            else { throw CommandError.optionMissingValue(Option.handle.rawValue) }
        
        self.handle = handle
    }
    
    // MARK: - Methods
    
    /// Read remote low energy features.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let features = try controller.lowEnergyReadRemoteUsedFeatures(connectionHandle: handle)
        
        print("LE Remote Features (\(features.count)):")
        features.forEach { print($0.name) }
    }
}

public extension LEReadRemoteFeaturesCommand {
    
    enum Option: String, OptionProtocol {
        
        case handle
        
        public static let all: Set<Option> = [.handle]
    }
}

