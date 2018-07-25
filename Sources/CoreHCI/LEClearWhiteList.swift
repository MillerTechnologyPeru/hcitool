//
//  ClearWhiteList.swift
//  hcitool
//
//  Created by Marco Estrella on 4/24/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEClearWhiteListCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyClearWhiteList
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    /// Tests the cleaning the white list.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.lowEnergyClearWhiteList()
    }
}
