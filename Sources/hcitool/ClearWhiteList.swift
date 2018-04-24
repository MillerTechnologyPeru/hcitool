//
//  ClearWhiteList.swift
//  hcitool
//
//  Created by Marco Estrella on 4/24/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct ClearWhiteListCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .clearWhiteList
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    /// Tests the Reading Local Name.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.lowEnergyClearWhiteList()
    }
}
