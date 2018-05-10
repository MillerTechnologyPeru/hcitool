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
        ("testUpdateConnection", testUpdateConnection),
        ("testSetAdvertisingEnable", testSetAdvertisingEnable),
        ("testEncrypt", testEncrypt),
        ("testLongTermKeyRequestReply", testLongTermKeyRequestReply),
        ("testLongTermKeyRequestNegativeReply", testLongTermKeyRequestNegativeReply)
    ]
    
    func testLongTermKeyRequestReply() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "longtermkeyrequestreply", "--connectionhandle", "0x0001", "--longtermkey", "0x1122334455667788"]
        
        testController.queue = [
            .command(LowEnergyCommand.longTermKeyReply.opcode,[0x1a, 0x20, 0x12, 0x01, 0x00, 0x31, 0x31, 0x32, 0x32, 0x33, 0x33, 0x34, 0x34, 0x35, 0x35, 0x36, 0x36, 0x37, 0x37, 0x38, 0x38]),
            .event([0x0E, 0x04, 0x01, 0x1A, 0x20, 0x02])
        ]
        
        //Command Complete [201A] - LE Long Term Key Request Reply - Unknown Connection Identifier (0x2)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testLongTermKeyRequestNegativeReply() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "longtermkeyrequestnegativereply", "--connectionhandle", "0x0001"]
        
        testController.queue = [
            .command(LowEnergyCommand.longTermKeyNegativeReply.opcode,[0x1B, 0x20, 0x02, 0x01, 0x00]),
            .event([0x0E, 0x04, 0x01, 0x1B, 0x20, 0x02])
        ]
        
        ///Command Complete [201B] - LE Long Term Key Request Reply - Unknown Connection Identifier (0x2)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testEncrypt() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "encrypt", "--key", "aaaaaaaaaaaaaaaa", "--data", "bbbbbbbbbbbbbbbb"]
        
        testController.queue = [
            .command(LowEnergyCommand.encrypt.opcode,[0x17, 0x20, 0x20, 0x61, 0x61, 0x61, 0x61, 0x61, 0x61, 0x61, 0x61, 0x61, 0x61, 0x61, 0x61, 0x61,
                                                                 0x61, 0x61, 0x61, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62, 0x62,
                                                                 0x62, 0x62, 0x62]),
            .event([0x0e, 0x14, 0x01, 0x17, 0x20, 0x00, 0x17, 0xe6, 0xa3, 0x95, 0x34, 0x84, 0x87, 0xd1, 0x37, 0x42,
                    0x57, 0x70, 0xa4, 0xb5, 0x49, 0x19])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testSetAdvertisingEnable() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "setadvertisingenable", "--enable", "true"]
        
        testController.queue = [
            .command(LowEnergyCommand.setAdvertiseEnable.opcode,[0x0A, 0x20, 0x01, 0x01]),
            .event([0x0E, 0x04, 0x01, 0x0A, 0x20, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
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
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "setadvertisingparameters", "--intervalmin", "20", "--intervalmax", "30", "--type",
                         "directed", "--ownaddresstype", "random", "--peeraddresstype", "public", "--peeraddress",
                         "54:39:A3:47:D8:77", "--channelmap", "channel37", "--filterpolicy", "any"]
        
        testController.queue = [
            .command(LowEnergyCommand.readChannelMap.opcode, [0x06, 0x20, 0x0f, 0x14, 0x00, 0x1e, 0x00, 0x01, 0x01, 0x00, 0x77, 0xd8, 0x47, 0xa3, 0x39, 0x54, 0x01, 0x00]),
            .event([0x0e, 0x04, 0x01, 0x06, 0x20, 0x12])
        ]
        
        //HCI Event - Command Complete [2006] - LE Set Advertising Parameters - Invalid HCI Command Parameters (0x12)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
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
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "connectionupdate", "--handle", "01", "--intervalmin", "6", "--intervalmax", "200",
                         "--latency", "200",  "--supervisiontimeout", "201", "--lengthmin", "20", "--lengthmax", "40"]
         
        testController.queue = [
            .command(LowEnergyCommand.connectionUpdate.opcode, [0x13, 0x20, 0x0e, 0x01, 0x00, 0x06, 0x00, 0xc8, 0x00, 0xc8, 0x00, 0xc9, 0x00, 0x14, 0x00, 0x28, 0x00]),
            .event([0x0f, 0x04, 0x02, 0x01, 0x13, 0x20])
        ]
        
        //HCI Event - Command Status - LE Connection Update - Unknown Connection Identifier (0x2)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testLEScan() {
         let testController = TestHostController()
         let arguments = [".build/debug/hcitool", "lescan", "--duration", "1000"]
         
        testController.queue = [
            .command(LowEnergyCommand.setScanEnable.opcode, [0x0C, 0x20, 0x02, 0x00, 0x01]),
            .event([0x0E, 0x04, 0x01, 0x0C, 0x20, 0x0C])
        ]
        
        // HCI Event - Command Complete [200C] - LE Set Scan Enable - Command Disallowed (0xC)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
}

