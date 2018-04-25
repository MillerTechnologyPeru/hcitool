//
//  ReadLocalSupportedFeatures.swift
//  hcitool
//
//  Created by Marco Estrella on 4/25/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct ReadLocalSupportedFeaturesCommand: CommandProtocol {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .readLocalSupportedFeatures
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Methods
    
    /// Tests the reading of local supported features
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        let lowEnergyFeatureSet = try controller.readLocalSupportedFeatures()
        
        print("Feature Set Count \(lowEnergyFeatureSet.count)")
        
        print("Items:")
        for  feature in lowEnergyFeatureSet {
            
            print("\(feature.name)")
        }
    }
}
