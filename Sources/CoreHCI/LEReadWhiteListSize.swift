//
//  LEReadWhiteListSize.swift
//  hcitool
//
//  Created by Marco Estrella on 4/29/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEReadWhiteListSizeCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReadWhiteListSize
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    /// Tests the Reading of the total number of White List entries that can be stored in the Controller.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let whiteListSize = try controller.lowEnergyReadWhiteListSize()
        
        print("White List Size = \(whiteListSize)")
    }
}
