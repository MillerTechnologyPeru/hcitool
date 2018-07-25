//
//  LERand.swift
//  hcitool
//
//  Created by Marco Estrella on 4/29/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LERandCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyRand
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    /// Tests the request the Controller to generate 8 octets of random data to be sent to the Host.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let randomNumber = try controller.lowEnergyRandom()
        
        print("Random Number = \(randomNumber)")
    }
}
