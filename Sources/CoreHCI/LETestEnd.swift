//
//  LETestEnd.swift
//  hcitool
//
//  Created by Marco Estrella on 5/11/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LETestEndCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyTestEnd
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let numberOfPackets = try controller.lowEnergyTestEnd()
        
        print("numberOfPackets =  \(numberOfPackets)")
    }
}

