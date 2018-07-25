//
//  InquiryCancel.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/25/18.
//
//

import Bluetooth
import Foundation

public struct InquiryCancelCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .inquiryCancel
    
    // MARK: - Initialization
    
    public init() { }
    
    /// Tests the request the Controller to generate 8 octets of random data to be sent to the Host.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.inquiryCancel()
    }
}
