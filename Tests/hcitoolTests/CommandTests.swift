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
        ("testLEScan", testLEScan),
        ("testSetRandomAddress", testSetRandomAddress),
        ("testClearWhiteList", testClearWhiteList),
        ("testCreateConnectionCancel", testCreateConnectionCancel),
        ("testReadLocalSupportedFeatures", testReadLocalSupportedFeatures),
        ("testReadbuffersize", testReadbuffersize),
        ("testSetAdvertiseEnableParameter", testSetAdvertiseEnableParameter),
        ("testReadChannelMap", testReadChannelMap),
        ("testAddDeviceToWhiteList", testAddDeviceToWhiteList),
        ("testRemoveDeviceFromWhiteList", testRemoveDeviceFromWhiteList),
        ("testUpdateConnection", testUpdateConnection)
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
    
    func testLEScan() {
        /*let testController = TestHostController()
         let arguments = [".build/debug/hcitool"]
         
         
         
         XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))*/
    }
    
    func testSetRandomAddress() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "setrandomaddress", "--address", "68:60:B2:29:26:8D"]
        
        testController.queue = [
            .command(LowEnergyCommand.setRandomAddress.opcode, [0x05, 0x20, 0x06, 0x8D, 0x26, 0x29, 0xB2, 0x60, 0x68]),
            .event([0x0E, 0x04, 0x01, 0x05, 0x20, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testClearWhiteList() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "clearwhitelist"]
        
        testController.queue = [
            .command(LowEnergyCommand.clearWhiteList.opcode, [0x10, 0x20, 0x00]),
            .event([0x0E, 0x04, 0x01, 0x10, 0x20, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testCreateConnectionCancel() {
        /*let testController = TestHostController()
        let arguments = [".build/debug/hcitool"]
        
        
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))*/
    }
    
    func testReadLocalSupportedFeatures() {
        /*let testController = TestHostController()
         let arguments = [".build/debug/hcitool"]
         
         
         
         XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))*/
    }
    
    func testSetAdvertiseEnableParameter() {
        /*let testController = TestHostController()
         let arguments = [".build/debug/hcitool"]
         
         
         
         XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))*/
    }
    
    func testReadChannelMap() {
        /*let testController = TestHostController()
         let arguments = [".build/debug/hcitool"]
         
         
         
         XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))*/
    }
    
    func testAddDeviceToWhiteList() {
        /*let testController = TestHostController()
         let arguments = [".build/debug/hcitool"]
         
         
         
         XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))*/
    }
    
    func testRemoveDeviceFromWhiteList() {
        /*let testController = TestHostController()
         let arguments = [".build/debug/hcitool"]
         
         
         
         XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))*/
    }
    
    func testUpdateConnection() {
        /*let testController = TestHostController()
         let arguments = [".build/debug/hcitool"]
         
         
         
         XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))*/
    }
}

