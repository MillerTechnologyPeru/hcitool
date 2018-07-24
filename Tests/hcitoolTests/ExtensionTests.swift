//
//  ExtensionTests.swift
//  hcitool
//
//  Created by Marco Estrella on 5/7/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import XCTest
@testable import hcitool

final class ExtensionTests: XCTestCase {
    
    static var allTests = [
        (testHexadecimalString, "testHexadecimalString")
    ]
    
    func testHexadecimalString() {
        
        XCTAssertNil(UInt8(commandLine: ""), "Cannot initialize from empty string")
        XCTAssertNil(UInt16(commandLine: ""), "Cannot initialize from empty string")
        XCTAssertNil(UInt32(commandLine: ""), "Cannot initialize from empty string")
        XCTAssertNil(UInt64(commandLine: ""), "Cannot initialize from empty string")
        XCTAssertNil(UInt128(commandLine: ""), "Cannot initialize from empty string")
        
        XCTAssertNil(UInt8(commandLine: "0xAAA"), "Cannot initialize from invalid string")
        XCTAssertNil(UInt16(commandLine: "0xAAA"), "Cannot initialize from invalid string")
        XCTAssertNil(UInt16(commandLine: "0xAAAAA"), "Cannot initialize from invalid string")
        XCTAssertNil(UInt32(commandLine: "0xAAAAAAAAA"), "Cannot initialize from invalid string")
        XCTAssertNil(UInt64(commandLine: "0xAAAAAAAAAAAAAAAAAA"), "Cannot initialize from invalid string")
        XCTAssertNil(UInt128(commandLine: "0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"), "Cannot initialize from empty string")
        
        XCTAssertEqual(UInt8(commandLine: "128"), 128, "Must initialize from valid decimal string")
        //XCTAssertEqual(UInt16(commandLine: "200"), 200, "Must initialize from valid decimal string")
        XCTAssertEqual(UInt32(commandLine: "2000100"), 2000100, "Must initialize from valid decimal string")
        XCTAssertEqual(UInt64(commandLine: "50005645"), 50005645, "Must initialize from valid decimal string")
        
        XCTAssertEqual(UInt8(commandLine: "0xAB"), 0xAB, "Must initialize from valid hexadecimal string")
        XCTAssertEqual(UInt16(commandLine: "0xABCD"), 0xABCD, "Must initialize from valid hexadecimal string")
        XCTAssertEqual(UInt32(commandLine: "0xAC2A30AE"), 0xAC2A30AE, "Must initialize from valid hexadecimal string")
        XCTAssertEqual(UInt64(commandLine: "0x02D2F33FFEAA2244"), 0x02D2F33FFEAA2244, "Must initialize from valid hexadecimal string")
        //XCTAssertEqual(UInt128(commandLine: "0x02D2F33FFEAA224402D2F33FFEAA2244"), 0x02D2F33FFEAA224402D2F33FFEAA2244, "Must initialize from valid hexadecimal string")
    }
}
