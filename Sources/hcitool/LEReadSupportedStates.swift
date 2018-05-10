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
    
    /// Tests the request the Controller to generate 8 octets of random data to be sent to the Host.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        //TODO: invoke controller method
        //let randomNumber = try controller.rea
    }
}
