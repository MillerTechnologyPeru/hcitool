//
//  CommandInformation.swift
//  hcitool
//
//  Created by Alsey Coleman Miller on 4/30/19.
//

import Foundation

public extension CommandType {
    
    var name: String {
        
        return commandNames[self] ?? "\(self)"
    }
}

internal let commandNames: [CommandType: String] = [
    .lowEnergyScan: "Low Energy Scan",
    .iBeacon: "iBeacon",
    .readLocalName: "Read local name",
    .writeLocalName: "Write local name"
]
