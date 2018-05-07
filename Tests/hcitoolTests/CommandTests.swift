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
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "createconnectioncancel"]
        
        testController.queue = [
            .command(LowEnergyCommand.createConnectionCancel.opcode, [0x0E, 0x20, 0x00]),
            .event([0x0E, 0x04, 0x01, 0x0E, 0x20, 0x0C])
        ]
        
        // Command Complete [200E] - LE Create Connection Cancel - Command Disallowed (0xC)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testReadLocalSupportedFeatures() {
        let testController = TestHostController()
         let arguments = [".build/debug/hcitool", "readlocalsupportedfeatures"]
         
        testController.queue = [
            .command(LowEnergyCommand.readLocalSupportedFeatures.opcode, [0x03, 0x20, 0x00]),
            .event([0x0e, 0x0c, 0x01, 0x03, 0x20, 0x00, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
        ]

        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testReadChannelMap() {
        let testController = TestHostController()
         let arguments = [".build/debug/hcitool", "readchannelmap", "--handle", "0x01"]
        
        testController.queue = [
            .command(LowEnergyCommand.readChannelMap.opcode, [0x15, 0x20, 0x02, 0x01, 0x00]),
            .event([0x0e, 0x04, 0x01, 0x15, 0x20, 0x02])
        ]
        
        //HCI Event - Command Complete [2015] - LE Read Channel Map - Unknown Connection Identifier (0x2)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testSetAdvertiseEnableParameter() {
        /*let testController = TestHostController()
         let arguments = [".build/debug/hcitool"]
         
         
         
         XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))*/
    }
    
    func testAddDeviceToWhiteList() {
         let testController = TestHostController()
         let arguments = [".build/debug/hcitool", "adddevicetowhitelist", "--addresstype", "random", "--address", "54:39:A3:47:D8:F8"]

        testController.queue = [
            .command(LowEnergyCommand.addDeviceToWhiteList.opcode, [0x11, 0x20, 0x07, 0x01, 0xf8, 0xd8, 0x47, 0xa3, 0x39, 0x54]),
            .event([0x0e, 0x04, 0x01, 0x11, 0x20, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testRemoveDeviceFromWhiteList() {
        let testController = TestHostController()
         let arguments = [".build/debug/hcitool", "removedevicefromwhitelist", "--addresstype", "random", "--address", "54:39:A3:47:D8:F8"]

        testController.queue = [
            .command(LowEnergyCommand.removeDeviceFromWhiteList.opcode, [0x12, 0x20, 0x07, 0x01, 0xf8, 0xd8, 0x47, 0xa3, 0x39, 0x54]),
            .event([0x0e, 0x04, 0x01, 0x12, 0x20, 0x00])
        ]
         XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testUpdateConnection() {
        /*let testController = TestHostController()
         let arguments = [".build/debug/hcitool"]
         
         
         
         XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))*/
    }
    
    func testLEScan() {
        /*let testController = TestHostController()
         let arguments = [".build/debug/hcitool"]
         
         
         
         XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))*/
    }
}

