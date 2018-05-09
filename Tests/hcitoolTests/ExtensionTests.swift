//
//  ExtensionTests.swift
//  hcitool
//
//  Created by Marco Estrella on 5/7/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import XCTest

final class ExtensionTests: XCTestCase {
    
    static var allTests = [
        (testHexadecimalString, "testHexadecimalString")
    ]
    
    func testHexadecimalString() {
        
        XCTAssertNil(UInt8(commandLine: ""), "Cannot initialize from empty string")
        XCTAssertNil(UInt16(commandLine: ""), "Cannot initialize from empty string")
        
        XCTAssertNil(UInt8(commandLine: "0xAAA"), "Cannot initialize from invalid string")
        XCTAssertNil(UInt16(commandLine: "0xAAA"), "Cannot initialize from invalid string")
        XCTAssertNil(UInt16(commandLine: "0xAAAAA"), "Cannot initialize from invalid string")
        
        XCTAssertEqual(UInt8(commandLine: "128"), 128, "Must initialize from valid decimal string")
        XCTAssertEqual(UInt16(commandLine: "2000"), 2000, "Must initialize from valid decimal string")
        
        XCTAssertEqual(UInt8(commandLine: "0xAB"), 0xAB, "Must initialize from valid hexadecimal string")
        XCTAssertEqual(UInt16(commandLine: "0xABCD"), 0xABCD, "Must initialize from valid hexadecimal string")
    }
    
    func testConvertStringToBool() {
        
        guard let _ = Bool(enable: "True")
            else { XCTFail("Wrong input string"); return }
        
        guard let _ = Bool(enable: "true")
            else { XCTFail("Wrong input string"); return }
        
        guard let _ = Bool(enable: "yes")
            else { XCTFail("Wrong input string"); return }
        
        guard let _ = Bool(enable: "1")
            else { XCTFail("Wrong input string"); return }
        
        guard let _ = Bool(enable: "False")
            else { XCTFail("Wrong input string"); return }
        
        guard let _ = Bool(enable: "false")
            else { XCTFail("Wrong input string"); return }
        
        guard let _ = Bool(enable: "no")
            else { XCTFail("Wrong input string"); return }
        
        guard let _ = Bool(enable: "1")
            else { XCTFail("Wrong input string"); return }
        
        XCTAssertNil(Bool(enable: "ASAS"), "Wrong input string")
    }
}
