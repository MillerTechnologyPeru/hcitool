//
//  CommandTests.swift
//  hcitool
//
//  Created by Marco Estrella on 5/7/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

import Bluetooth
import XCTest
@testable import CoreHCI

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
        ("testLongTermKeyRequestNegativeReply", testLongTermKeyRequestNegativeReply),
        ("testLEReceiverTest", testLEReceiverTest),
        ("testTransmitterTest", testTransmitterTest),
        ("testTestEnd", testTestEnd),
        ("testReadSupportedStates", testReadSupportedStates),
        ("testAddDeviceToResolvingList", testAddDeviceToResolvingList),
        ("testInquiry", testInquiry),
        ("testInquiryCancel", testInquiryCancel),
        ("testPeriodicInquiryModeAndCancel", testPeriodicInquiryModeAndCancel)
    ]
    
    func testRemoveDeviceFromResolvingList() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool",  "removedevicefromresolvinglist", "--peeridentifyaddresstype", "public", "--peeridentifyaddress", "0x1122334455667788"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.addDeviceToResolvedList.opcode,[0x28, 0x20, 0x09, 0x01, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11]),
            .event([0x0e, 0x04, 0x01, 0x28, 0x20, 0x0c])
        ]
        
        // Command Complete [2028] - LE Remove From Resolving List - Command Disallowed (0xC)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testAddDeviceToResolvingList() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "adddevicetoresolvinglist", "--peeridentifyaddresstype", "public", "--peeridentifyaddress", "0x1122334455667788", "--peerirk",           "0x11223344556677881122334455667788", "--localirk", "0x11223344556677881122334455667788"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.addDeviceToResolvedList.opcode,[0x27, 0x20, 0x29, 0x00, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11,
                                                                      0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11, 0x88, 0x77, 0x66, 0x55,
                                                                      0x44, 0x33, 0x22, 0x11, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11,
                                                                      0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11]),
            .event([0x0e, 0x04, 0x01, 0x27, 0x20, 0x0c])
        ]
        
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testReadSupportedStates() {
    
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "readsupportedstates"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.readSupportedStates.opcode,[0x1c, 0x20, 0x00]),
            .event([0x0e, 0x0c, 0x01, 0x1c, 0x20, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0x03, 0x00, 0x00])
        ]
        
        //garbageResponse(8 bytes)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testTestEnd() {
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "testend"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.testEnd.opcode,[0x1f, 0x20, 0x00]),
            .event([0x0e, 0x06, 0x01, 0x1f, 0x20, 0x00, 0x00, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testTransmitterTest() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "transmittertest", "--txchannel", "0x01", "--length", "0x02", "--payload", "0x02"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.transmitterTest.opcode,[0x1e, 0x20, 0x02, 0x01, 0x02]),
            .event([0x0e, 0x04, 0x01, 0x1e, 0x20, 0x0c])
        ]
        
        //Command Complete [201D] - LE Receiver Test - Command Disallowed (0xC)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testLEReceiverTest() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "receivertest", "--rxchannel", "0x01"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.receiverTest.opcode,[0x1d, 0x20, 0x01, 0x02]),
            .event([0x0e, 0x04, 0x01, 0x1d, 0x20, 0x0c])
        ]
        
        //Command Complete [201D] - LE Receiver Test - Command Disallowed (0xC)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testLongTermKeyRequestReply() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "longtermkeyrequestreply", "--connectionhandle", "0x0001", "--longtermkey", "0x1122334455667788"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.longTermKeyReply.opcode,[0x1a, 0x20, 0x12, 0x01, 0x00, 0x31, 0x31, 0x32, 0x32, 0x33, 0x33, 0x34, 0x34, 0x35, 0x35, 0x36, 0x36, 0x37, 0x37, 0x38, 0x38]),
            .event([0x0E, 0x04, 0x01, 0x1A, 0x20, 0x02])
        ]
        
        //Command Complete [201A] - LE Long Term Key Request Reply - Unknown Connection Identifier (0x2)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testLongTermKeyRequestNegativeReply() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "longtermkeyrequestnegativereply", "--connectionhandle", "0x0001"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.longTermKeyNegativeReply.opcode,[0x1B, 0x20, 0x02, 0x01, 0x00]),
            .event([0x0E, 0x04, 0x01, 0x1B, 0x20, 0x02])
        ]
        
        ///Command Complete [201B] - LE Long Term Key Request Reply - Unknown Connection Identifier (0x2)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testEncrypt() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "encrypt", "--key", "11223344556677881122334455667788", "--data", "11223344556677881122334455667788"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.encrypt.opcode, [0x17, 0x20, 0x20, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22,
                                                       0x11, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11]),
            
            .event([0x0e, 0x14, 0x01, 0x17, 0x20, 0x00, 0xd1, 0x2a, 0x1a, 0x7d, 0x05, 0x0b, 0xd9, 0xef, 0xd0, 0x4f, 0x93, 0x63, 0x5c, 0x9e, 0xf5, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testSetAdvertisingEnable() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "setadvertisingenable", "--enable", "true"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.setAdvertiseEnable.opcode,[0x0A, 0x20, 0x01, 0x01]),
            .event([0x0E, 0x04, 0x01, 0x0A, 0x20, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testReadbuffersize() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "readbuffersize"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.readBufferSize.opcode,[0x02, 0x20, 0x00]),
            .event([0x0E, 0x07, 0x01, 0x02, 0x20, 0x00, 0xFB, 0x00, 0x0F])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testSetRandomAddress() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "setrandomaddress", "--address", "68:60:B2:29:26:8D"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.setRandomAddress.opcode, [0x05, 0x20, 0x06, 0x8D, 0x26, 0x29, 0xB2, 0x60, 0x68]),
            .event([0x0E, 0x04, 0x01, 0x05, 0x20, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testClearWhiteList() {
        
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "clearwhitelist"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.clearWhiteList.opcode, [0x10, 0x20, 0x00]),
            .event([0x0E, 0x04, 0x01, 0x10, 0x20, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testCreateConnectionCancel() {
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "createconnectioncancel"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.createConnectionCancel.opcode, [0x0E, 0x20, 0x00]),
            .event([0x0E, 0x04, 0x01, 0x0E, 0x20, 0x0C])
        ]
        
        // Command Complete [200E] - LE Create Connection Cancel - Command Disallowed (0xC)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testReadLocalSupportedFeatures() {
        let testController = TestHostController()
         let arguments = [".build/debug/hcitool", "readlocalsupportedfeatures"]
         
        testController.queue = [
            .command(HCILowEnergyCommand.readLocalSupportedFeatures.opcode, [0x03, 0x20, 0x00]),
            .event([0x0e, 0x0c, 0x01, 0x03, 0x20, 0x00, 0x3f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
        ]

        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testReadChannelMap() {
        let testController = TestHostController()
         let arguments = [".build/debug/hcitool", "readchannelmap", "--handle", "0x01"]
        
        testController.queue = [
            .command(HCILowEnergyCommand.readChannelMap.opcode, [0x15, 0x20, 0x02, 0x01, 0x00]),
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
            .command(HCILowEnergyCommand.readChannelMap.opcode, [0x06, 0x20, 0x0f, 0x14, 0x00, 0x1e, 0x00, 0x01, 0x01, 0x00, 0x77, 0xd8, 0x47, 0xa3, 0x39, 0x54, 0x01, 0x00]),
            .event([0x0e, 0x04, 0x01, 0x06, 0x20, 0x12])
        ]
        
        //HCI Event - Command Complete [2006] - LE Set Advertising Parameters - Invalid HCI Command Parameters (0x12)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testAddDeviceToWhiteList() {
         let testController = TestHostController()
         let arguments = [".build/debug/hcitool", "adddevicetowhitelist", "--addresstype", "random", "--address", "54:39:A3:47:D8:F8"]

        testController.queue = [
            .command(HCILowEnergyCommand.addDeviceToWhiteList.opcode, [0x11, 0x20, 0x07, 0x01, 0xf8, 0xd8, 0x47, 0xa3, 0x39, 0x54]),
            .event([0x0e, 0x04, 0x01, 0x11, 0x20, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testRemoveDeviceFromWhiteList() {
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "removedevicefromwhitelist", "--addresstype", "random", "--address", "54:39:A3:47:D8:F8"]

        testController.queue = [
            .command(HCILowEnergyCommand.removeDeviceFromWhiteList.opcode, [0x12, 0x20, 0x07, 0x01, 0xf8, 0xd8, 0x47, 0xa3, 0x39, 0x54]),
            .event([0x0e, 0x04, 0x01, 0x12, 0x20, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testUpdateConnection() {
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "connectionupdate", "--handle", "01", "--intervalmin", "6", "--intervalmax", "200",
                         "--latency", "200",  "--supervisiontimeout", "201", "--lengthmin", "20", "--lengthmax", "40"]
         
        testController.queue = [
            .command(HCILowEnergyCommand.connectionUpdate.opcode, [0x13, 0x20, 0x0e, 0x01, 0x00, 0x06, 0x00, 0xc8, 0x00, 0xc8, 0x00, 0xc9, 0x00, 0x14, 0x00, 0x28, 0x00]),
            .event([0x0f, 0x04, 0x02, 0x01, 0x13, 0x20])
        ]
        
        //HCI Event - Command Status - LE Connection Update - Unknown Connection Identifier (0x2)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testLEScan() {
         let testController = TestHostController()
         let arguments = [".build/debug/hcitool", "lescan", "--duration", "1000"]
         
        testController.queue = [
            .command(HCILowEnergyCommand.setScanEnable.opcode, [0x0C, 0x20, 0x02, 0x00, 0x01]),
            .event([0x0E, 0x04, 0x01, 0x0C, 0x20, 0x0C])
        ]
        
        // HCI Event - Command Complete [200C] - LE Set Scan Enable - Command Disallowed (0xC)
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testInquiry() {
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "inquiry", "--lap", "009E8B00", "--length", "05", "--responses", "20"]
        
        testController.queue = [
            .command(LinkControlCommand.inquiry.opcode, [0x01, 0x04, 0x05, 0x00, 0x8b, 0x9e, 0x05, 0x20]),
            .event([0x0f, 0x04, 0x00, 0x01, 0x01, 0x04])
        ]
        
        XCTAssertThrowsError(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testInquiryCancel() {
        let testController = TestHostController()
        let arguments = [".build/debug/hcitool", "inquirycancel"]
        
        testController.queue = [
            .command(LinkControlCommand.inquiryCancel.opcode, [0x02, 0x04, 0x00]),
            .event([0x0e, 0x04, 0x01, 0x02, 0x04, 0x00])
        ]
        
        XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
    }
    
    func testPeriodicInquiryModeAndCancel() {
        do {
            let testController = TestHostController()
            let arguments = [".build/debug/hcitool", "periodicinquirymode", "--maxperiodlength", "0009", "--minperiodlength", "0005", "--lap", "009E8B00", "--length", "03", "--responses", "20"]
            
            
            testController.queue = [
                .command(LinkControlCommand.periodicInquiry.opcode, [0x03, 0x04, 0x09, 0x09, 0x00, 0x05, 0x00, 0x00, 0x8b, 0x9e, 0x03, 0x20]),
                .event([0x0e, 0x04, 0x01, 0x03, 0x04, 0x00])
            ]
            
            XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
        }
        
        do {
            let testController = TestHostController()
            let arguments = [".build/debug/hcitool", "exitperiodicinquirymode"]
            
            testController.queue = [
                .command(LinkControlCommand.exitPeriodicInquiry.opcode, [0x04, 0x04, 0x00]),
                .event([0x0e, 0x04, 0x01, 0x04, 0x04, 0x00])
            ]
            
            XCTAssertNoThrow(try HCIToolTests.run(arguments: arguments, controller: testController))
        }
    }
    
}

