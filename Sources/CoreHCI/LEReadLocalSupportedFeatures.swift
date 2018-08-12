//
//  ReadLocalSupportedFeatures.swift
//  hcitool
//
//  Created by Marco Estrella on 4/25/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct LEReadLocalSupportedFeaturesCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .lowEnergyReadLocalSupportedFeatures
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    /// Reading the local supported features.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let features = try controller.readLocalSupportedFeatures()
        
        print("LE Local Features (\(features.count)):")
        features.forEach { print($0.name) }
    }
}
