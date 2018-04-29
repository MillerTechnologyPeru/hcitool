//
//  LEReadAdvertisingChannelTxPower.swift
//  hcitool
//
//  Created by Marco Estrella on 4/29/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEReadAdvertisingChannelTxPowerCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReadAdvertisingChannelTxPower
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    /// Tests the reading of the transmit power level used for LE advertising channel packets.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let transmitPowerLevel = try controller.readAdvertisingChannelTxPower()
        
        print("Transmit Power Level = \(transmitPowerLevel.rawValue)")
    }
}

