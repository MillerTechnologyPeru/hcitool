//
//  ReadLocalName.swift
//  hcitool
//
//  Created by Marco Estrella on 3/27/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct ReadLocalNameCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .readLocalName
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    /// Tests the Reading Local Name.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let localName = try controller.readLocalName()
        
        print("Local name: \(localName)")
    }
}
