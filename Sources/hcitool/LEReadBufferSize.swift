//
//  ReadBufferSize.swift
//  hcitool
//
//  Created by Marco Estrella on 4/25/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEReadBufferSizeCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergySetReadBufferSize
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    /// Tests the Reading the maximum size of the data portion of HCI LE ACL Data Packets sent from the Host to the Controller.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let result = try controller.readBufferSize()
        
        print("Data Packet Length = \(Int16(bitPattern: result.dataPacketLength))")
        
        print("Data Packet = \(Int8(bitPattern: result.dataPacket))")
    }
}
