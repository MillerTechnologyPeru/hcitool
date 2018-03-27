//
//  HCIToolTests.swift
//  PureSwift
//
//  Created by Alsey Coleman Miller on 3/27/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import XCTest
@testable import hcitool

final class HCIToolTests: XCTestCase {
    
    static var allTests = [
        ("testLEScan", testLEScan)
    ]
    
    func testLEScan() {
        
        // LE scan with specified duration
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "lescan", "--duration", "1000"]
            
            let command = try Command(arguments: arguments)
            
            guard case let .leScan(commandValue) = command
                else { XCTFail("Invalid type"); return }
            
            XCTAssert(commandValue.duration == 1000)
            
        } catch { XCTFail("\(error)") }
        
        // LE scan with default duration
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "lescan"]
            
            let command = try Command(arguments: arguments)
            
            guard case let .leScan(commandValue) = command
                else { XCTFail("Invalid type"); return }
            
            XCTAssert(commandValue.duration == LEScanCommand.default.duration)
            
        } catch { XCTFail("\(error)") }
        
        // invalid commands
        XCTAssertThrowsError(try Command(arguments: ["lescan", "--duration"]))
        XCTAssertThrowsError(try Command(arguments: ["lescan", "--duration", "abc"]))
    }
}
