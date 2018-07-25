//
//  LEReadResolvingListSize.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/24/18.
//
//

import Bluetooth
import Foundation

public struct LEReadResolvingListSizeCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReadResolvingListSize
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - Methods
    
    /// Tests removing a device from the LE white list.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let numberofAddress = try controller.lowEnergyReadResolvingListSize()
        
        print("Number of address = ", numberofAddress)
    }
}
