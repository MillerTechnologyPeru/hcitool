//
//  ReadDataBlockSize.swift
//  CoreHCI
//
//  Created by Carlos Duclos on 8/6/18.
//

import Foundation
import Bluetooth

public struct ReadDataBlockSizeCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .readDataBlockSize
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    /// Tests the reading of the transmit power level used for LE advertising channel packets.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let dataBlockSize = try controller.readDataBlockSize()
        
        print("Status = \(dataBlockSize.status.description)")
        print("Max ACL data packet length = \(dataBlockSize.maxACLDataPacketLength)")
        print("Data block length = \(dataBlockSize.dataBlockLength)")
        print("Data blocks total number = \(dataBlockSize.dataBlocksTotalNumber)")
    }
}
