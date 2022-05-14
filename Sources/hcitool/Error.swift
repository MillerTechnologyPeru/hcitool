//
//  Error.swift
//  hcitool
//
//  Created by Alsey Coleman Miller on 3/27/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import BluetoothLinux

public enum CommandError: Error {
    
    /// Bluetooth controllers not availible.
    case invalidDevice(String)
}
