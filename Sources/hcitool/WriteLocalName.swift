//
//  WriteLocalName.swift
//  hcitool
//
//  Created by Marco Estrella on 3/27/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import Foundation

public struct WriteLocalNameCommand: ArgumentableCommand {
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .writeLocalName
    
    public var name: String
    
    // MARK: - Initialization
    
    public init(name: String){
        self.name = name
    }
    
    public init(options: [Option: String]) throws {
        
        guard let nameString = options[.name]
            else { throw CommandError.optionMissingValue(Option.name.rawValue) }
        
        self.name = nameString
    }
    
    // MARK: - Methods
    
    /// Tests the Reading Local Name.
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.writeLocalName(name)
        
        print("Changed Local Name: \(name)")
    }
}

public extension WriteLocalNameCommand {
    
    public enum Option: String, OptionProtocol {

        case name
        
        public static let all: Set<Option> = [.name]
    }
}
