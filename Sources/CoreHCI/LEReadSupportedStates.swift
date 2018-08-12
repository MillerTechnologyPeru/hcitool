//
//  LEReadSupportedStates.swift
//  hcitool
//
//  Created by Marco Estrella on 5/10/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEReadSupportedStatesCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReadSupportedStates
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let lowEnergyStateSet = try controller.readSupportedStates()
        
        print("LE Supported States (\(lowEnergyStateSet.states.count)):")
        lowEnergyStateSet.states.forEach { print($0.name) }
    }
}
