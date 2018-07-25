//
//  LEClearResolvingListCommand.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/24/18.
//
//

import Bluetooth
import Foundation

public struct LEClearResolvingListCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyClearResolvingList
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    /// Tests the cleaning the white list.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.lowEnergyClearResolvingList()
    }
}
