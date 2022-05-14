//
//  hcitool.swift
//  
//
//  Created by Alsey Coleman Miller on 5/14/22.
//

import Foundation
import ArgumentParser
import Bluetooth

@main
struct HCITool: AsyncParsableCommand {
    
    static let configuration = CommandConfiguration(
        commandName: "hcitool",
        abstract: "",
        version: "1.0.0",
        subcommands: [
            ListDevices.self,
            LEScan.self,
        ]
    )
}
