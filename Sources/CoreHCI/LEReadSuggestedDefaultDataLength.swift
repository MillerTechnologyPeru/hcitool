//
//  LEReadsuggestedDefaultDataLength.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/23/18.
//
//

import Bluetooth
import Foundation

public struct LEReadSuggestedDefaultDataLengthCommand: CommandProtocol {

    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReadSuggestedDefaultDataLength
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Methods
    
    public func execute<Controller>(controller: Controller) throws where Controller : BluetoothHostControllerInterface {
    
        let dataLength = try controller.lowEnergyReadSuggestedDefaultDataLength()
        print("suggested max tx octets = ", dataLength.suggestedMaxTxOctets.rawValue.toHexadecimal())
        print("suggested max tx time = ", dataLength.suggestedMaxTxTime.rawValue.toHexadecimal())
    }
}
