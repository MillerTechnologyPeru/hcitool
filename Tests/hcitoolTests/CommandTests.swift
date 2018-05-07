//
//  CommandTests.swift
//  hcitool
//
//  Created by Marco Estrella on 5/7/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import XCTest
@testable import hcitool

final class CommandTests: XCTestCase {
    
    static var allTests = [
        ("testReadbuffersize", testReadbuffersize)
    ]
    
    func testReadbuffersize() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "readbuffersize"]
        
        testController.queue = [
            .command(LowEnergyCommand.readBufferSize.opcode,[0x02, 0x20, 0x00]),
            .event([0x0E, 0x07, 0x01, 0x02, 0x20, 0x00, 0xFB, 0x00, 0x0F])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
        
    }
}

