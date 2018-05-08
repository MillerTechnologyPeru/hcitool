//
//  HCIToolTests.swift
//  PureSwift
//
//  Created by Alsey Coleman Miller on 3/27/18.
//  Copyright © 2018 PureSwift. All rights reserved.
//

import XCTest
@testable import hcitool

final class ArgumentTests: XCTestCase {
    
    static var allTests = [
        ("testLEScan", testLEScan),
        ("testSetRandomAddress", testSetRandomAddress),
        ("testClearWhiteList", testClearWhiteList),
        ("testCreateConnectionCancel", testCreateConnectionCancel),
        ("testReadLocalSupportedFeatures", testReadLocalSupportedFeatures),
        ("testReadBufferSize", testReadBufferSize),
        ("testSetAdvertiseParameter", testSetAdvertiseParameter),
        ("testReadChannelMap", testReadChannelMap),
        ("testAddDeviceToWhiteList", testAddDeviceToWhiteList),
        ("testRemoveDeviceFromWhiteList", testRemoveDeviceFromWhiteList),
        ("testUpdateConnection", testUpdateConnection),
        ("testSetAdvertisingEnable", testSetAdvertisingEnable)
    ]
    
    func testSetAdvertisingEnable() {
        
        /*
         [200A] Opcode: 0x200A (OGF: 0x08    OCF: 0x0A) - 0A 20 01 01
         Parameter Length: 1 (0x01)
         Advertising Enable: 01
         */
        
        /*
         Parameter Length: 4 (0x04)
         Status: 0x00 - Success
         Num HCI Command Packets: 0x01
         Opcode: 0x200A (OGF: 0x08    OCF: 0x0A) - [Low Energy] LE Set Advertise Enable - 0E 04 01 0A 20 00
         */
        
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "setadvertisingenable", "--enable", "True"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergySetAdvertisingEnable = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "setadvertisingenable", "--enable", "true"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergySetAdvertisingEnable = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "setadvertisingenable", "--enable", "yes"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergySetAdvertisingEnable = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "setadvertisingenable", "--enable", "1"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergySetAdvertisingEnable = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "setadvertisingenable", "--enable", "False"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergySetAdvertisingEnable = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "setadvertisingenable", "--enable", "false"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergySetAdvertisingEnable = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "setadvertisingenable", "--enable", "no"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergySetAdvertisingEnable = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "setadvertisingenable", "--enable", "0"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergySetAdvertisingEnable = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        XCTAssertThrowsError(try Command(arguments: ["setadvertisingenable", "--enable", "asas"]))
    }
    
    func testUpdateConnection() {
        
        /*
         [2013] Opcode: 0x2013 (OGF: 0x08    OCF: 0x13) - 13 20 0e 01 00 06 00 c8 00 c8 00 c9 00 14 00 28 00
         Parameter Length: 14 (0x0E)
         Connection Handle:   0x0001
         Conn Interval Min: 0X0006 (7.5 ms)
         Conn Interval Max: 0X00C8 (250 ms)
         Conn Slave Latency: 0x00C8 (200)
         Supervision Timeout: 0x00C9 (2010 ms)
         Minimum CE Length:   0x0014
         Maximum CE Length:   0x0028
         */
        
        /*
         Parameter Length: 4 (0x04)
         Status: 0x02 - Unknown Connection Identifier
         Num HCI Command Packets: 0x01
         Opcode: 0x2013 (OGF: 0x08    OCF: 0x13) - [Low Energy] LE Connection Update - 0f 04 02 01 13 20
         */
        //Handle hexadecimal with prefix
        do {
            let arguments = [/* ".build/debug/hcitool", */ "connectionupdate", "--handle", "01",
                                                                                "--intervalmin", "6",
                                                                                "--intervalmax", "200",
                                                                                "--latency", "200",
                                                                                "--supervisiontimeout", "201",
                                                                                "--lengthmin", "20",
                                                                                "--lengthmax", "40"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyConnectionUpdate = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        //Handle hexadecimal with prefix
        do {
            let arguments = [/* ".build/debug/hcitool", */ "connectionupdate", "--handle", "01",
                                                                               "--intervalmin", "6",
                                                                               "--intervalmax", "200",
                                                                               "--latency", "200",
                                                                               "--supervisiontimeout", "201",
                                                                               "--lengthmin", "20",
                                                                               "--lengthmax", "40"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyConnectionUpdate = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        // invalid commands
        
        //Not handle value
        XCTAssertThrowsError(try Command(arguments: ["connectionupdate", "--handle",
                                                                         "--intervalmin", "6",
                                                                         "--intervalmax", "200",
                                                                        "--latency", "200",
                                                                        "--supervisiontimeout", "201",
                                                                        "--lengthmin", "20",
                                                                        "--lengthmax", "40"]))
        
        //Wrong handle format
        XCTAssertThrowsError(try Command(arguments: ["connectionupdate", "--handle", "x01",
                                                                         "--intervalmin", "6",
                                                                         "--intervalmax", "200",
                                                                        "--latency", "200",
                                                                        "--supervisiontimeout", "201",
                                                                        "--lengthmin", "20",
                                                                        "--lengthmax", "40"]))
        
        //intervalmin is not in the range of 6 and 3200
        XCTAssertThrowsError(try Command(arguments: ["connectionupdate", "--handle", "0x01",
                                                     "--intervalmin", "5",
                                                     "--intervalmax", "200",
                                                     "--latency", "200",
                                                     "--supervisiontimeout", "201",
                                                     "--lengthmin", "20",
                                                     "--lengthmax", "40"]))
        
        //intervalmax is not in the range of 6 and 3200
        XCTAssertThrowsError(try Command(arguments: ["connectionupdate", "--handle", "0x01",
                                                     "--intervalmin", "6",
                                                     "--intervalmax", "3201",
                                                     "--latency", "200",
                                                     "--supervisiontimeout", "201",
                                                     "--lengthmin", "20",
                                                     "--lengthmax", "40"]))
        
        //latency is not in the range of 6 and 3200
        XCTAssertThrowsError(try Command(arguments: ["connectionupdate", "--handle", "0x01",
                                                     "--intervalmin", "6",
                                                     "--intervalmax", "200",
                                                     "--latency", "3201",
                                                     "--supervisiontimeout", "201",
                                                     "--lengthmin", "20",
                                                     "--lengthmax", "40"]))
        
        //supervisiontimeout is not in the range of 10 and 3200
        XCTAssertThrowsError(try Command(arguments: ["connectionupdate", "--handle", "0x01",
                                                     "--intervalmin", "6",
                                                     "--intervalmax", "200",
                                                     "--latency", "200",
                                                     "--supervisiontimeout", "3201",
                                                     "--lengthmin", "20",
                                                     "--lengthmax", "40"]))
        
        //lengthmin is not in the range of 0 and 65535
        XCTAssertThrowsError(try Command(arguments: ["connectionupdate", "--handle", "0x01",
                                                     "--intervalmin", "6",
                                                     "--intervalmax", "200",
                                                     "--latency", "200",
                                                     "--supervisiontimeout", "3201",
                                                     "--lengthmin", "-1",
                                                     "--lengthmax", "40"]))
        
        //lengthmax is not in the range of 0 and 65535
        XCTAssertThrowsError(try Command(arguments: ["connectionupdate", "--handle", "0x01",
                                                     "--intervalmin", "6",
                                                     "--intervalmax", "200",
                                                     "--latency", "200",
                                                     "--supervisiontimeout", "3201",
                                                     "--lengthmin", "20",
                                                     "--lengthmax", "65536"]))
        
        //supervisiontimeout > intervalmax
        XCTAssertNoThrow(try Command(arguments: ["connectionupdate", "--handle", "0x01",
                                                     "--intervalmin", "6",
                                                     "--intervalmax", "100",
                                                     "--latency", "200",
                                                     "--supervisiontimeout", "1000",
                                                     "--lengthmin", "20",
                                                     "--lengthmax", "40"]))
    }
    
    func testReadBufferSize(){
        do {
            /*
             [2002] Opcode: 0x2002 (OGF: 0x08    OCF: 0x02)
             Parameter Length: 0 (0x00)
             */
            
            let arguments = [/* ".build/debug/hcitool", */ "readbuffersize"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyReadBufferSize = command
                else { XCTFail("Invalid type"); return }
            
            /*
             Parameter Length: 7 (0x07)
             Status: 0x00 - Success
             Num HCI Command Packets: 0x01
             Opcode: 0x2002 (OGF: 0x08    OCF: 0x02) - [Low Energy] LE Read Buffer Size
             HC LE Data Packet Length: 0x00FB
             HC Total Num LE Data Packets: 0x000F
             */
        } catch { XCTFail("\(error)") }
    }
    
    func testReadLocalSupportedFeatures(){
        do {
            /*
             [2003] Opcode: 0x2003 (OGF: 0x08    OCF: 0x03) - 03 20 00
             Parameter Length: 0 (0x00)
             */
            
            let arguments = [/* ".build/debug/hcitool", */ "readlocalsupportedfeatures"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyReadLocalSupportedFeatures = command
                else { XCTFail("Invalid type"); return }
            
            /* Command Complete [2003] - LE Read Local Supported Features - 0e 0c 01 03 20 00 3f 00 00 00 00 00 00 00
             Parameter Length: 12 (0x0C)
             Status: 0x00 - Success
             Num HCI Command Packets: 0x01
             Opcode: 0x2003 (OGF: 0x08    OCF: 0x03) - [Low Energy] LE Read Local Supported Features
             LE Features: 0X000000000000003F
             LE Encryption
             Connection Parameters Request Procedure
             Extended Reject Indication
             Slave-initiated Features Exchange
             LE Ping
             LE Data Packet Length Extension
             */
       } catch { XCTFail("\(error)") }
    }
    
    func testCreateConnectionCancel() {
        do {
            /*
             [200E] Opcode: 0x200E (OGF: 0x08    OCF: 0x0E) - 0E 20 00
             Parameter Length: 0 (0x00)
             */
            let arguments = [/* ".build/debug/hcitool", */ "createconnectioncancel"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyCreateConnectionCancel = command
                else { XCTFail("Invalid type"); return }
            
            /*
             Parameter Length: 4 (0x04)
             Status: 0x0C - Command Disallowed
             Num HCI Command Packets: 0x01
             Opcode: 0x200E (OGF: 0x08    OCF: 0x0E) - [Low Energy] LE Create Connection Cancel - 0E 04 01 0E 20 0C
             */
        } catch { XCTFail("\(error)") }
    }
    
    func testClearWhiteList() {
        do {
            /*
             [2010] Opcode: 0x2010 (OGF: 0x08    OCF: 0x10) - 10 20 00
             Parameter Length: 0 (0x00)
             */
            let arguments = [/* ".build/debug/hcitool", */ "clearwhitelist"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyClearWhiteList = command
                else { XCTFail("Invalid type"); return }
            
            /*
             Parameter Length: 4 (0x04)
             Status: 0x00 - Success
             Num HCI Command Packets: 0x01
             Opcode: 0x2010 (OGF: 0x08    OCF: 0x10) - [Low Energy] LE Clear White List - 0E 04 01 10 20 00
             */
            
        } catch { XCTFail("\(error)") }
    }
    
    func testReadChannelMap() {
        
        /*
         [2015] Opcode: 0x2015 (OGF: 0x08    OCF: 0x15) - 15 20 02 01 00
         Parameter Length: 2 (0x02)
         Connection Handle: 0001
         */
        
        /*
         Parameter Length: 4 (0x04)
         Status: 0x02 - Unknown Connection Identifier
         Num HCI Command Packets: 0x01
         Opcode: 0x2015 (OGF: 0x08    OCF: 0x15) - [Low Energy] LE Read Channel Map -  0e 04 01 15 20 02
         */
        //Handle hexadecimal without prefix
        do {
            let arguments = [/* ".build/debug/hcitool", */ "readchannelmap", "--handle", "01"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyReadChannelMap = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        //Handle hexadecimal with prefix
        do {
            let arguments = [/* ".build/debug/hcitool", */ "readchannelmap", "--handle", "0x01"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyReadChannelMap = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        // invalid commands
        XCTAssertThrowsError(try Command(arguments: ["readchannelmap", "--handle"]))
        XCTAssertThrowsError(try Command(arguments: ["readchannelmap", "--handle", "x01"]))
    }
    
    func testAddDeviceToWhiteList() {
        
        //Execute command with address
        do {
            /**
             [2011] Opcode: 0x2011 (OGF: 0x08    OCF: 0x11) -  1120 0701 f8d8 47a3 3954
             Parameter Length: 7 (0x07)
             Address Type: Random
             Address: 54:39:A3:47:D8:F8
             */
            let arguments = [/* ".build/debug/hcitool", */ "adddevicetowhitelist", "--addresstype", "random", "--address", "54:39:A3:47:D8:F8"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyAddDeviceToWhiteList = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        //Execute command with address
        do {
            /**
             [2011] Opcode: 0x2011 (OGF: 0x08    OCF: 0x11) -  1120 0701 f8d8 47a3 3954
             Parameter Length: 7 (0x07)
             Address Type: Anonymous
             */
            let arguments = [/* ".build/debug/hcitool", */ "adddevicetowhitelist", "--addresstype", "anonymous"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyAddDeviceToWhiteList = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        // invalid commands
        XCTAssertThrowsError(try Command(arguments: ["adddevicetowhitelist", "--addresstype"]))
        XCTAssertThrowsError(try Command(arguments: ["adddevicetowhitelist", "--addresstype", "--address"]))
        XCTAssertThrowsError(try Command(arguments: ["adddevicetowhitelist", "--addresstype", "public"]))
        XCTAssertThrowsError(try Command(arguments: ["adddevicetowhitelist", "--addresstype", "public", "--address"]))
    }
    
    func testRemoveDeviceFromWhiteList() {
        
        //Execute command with address
        do {
            /**
             [2012] Opcode: 0x2012 (OGF: 0x08    OCF: 0x12) - 0E 0A 01 09 10 00 6C 9A BA 32 BC AC
             Parameter Length: 7 (0x07)
             Address Type: Random
             Address: 54:39:A3:47:D8:D1
             */
            let arguments = [/* ".build/debug/hcitool", */ "removedevicefromwhitelist", "--addresstype", "random", "--address", "54:39:A3:47:D8:D1"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyRemoveDeviceFromWhiteList = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        //Execute command with address
        do {
            /**
             [2012] Opcode: 0x2012 (OGF: 0x08    OCF: 0x12) - 12 20 07 ff 00 00 00 00 00 00
             Parameter Length: 7 (0x07)
             Address Type: Reserved for future use: FF
             Address: 00:00:00:00:00:00
             */
            let arguments = [/* ".build/debug/hcitool", */ "removedevicefromwhitelist", "--addresstype", "anonymous"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergyRemoveDeviceFromWhiteList = command
                else { XCTFail("Invalid type"); return }
        } catch { XCTFail("\(error)") }
        
        // invalid commands
        XCTAssertThrowsError(try Command(arguments: ["removedevicefromwhitelist", "--addresstype"]))
        XCTAssertThrowsError(try Command(arguments: ["removedevicefromwhitelist", "--addresstype", "--address"]))
        XCTAssertThrowsError(try Command(arguments: ["removedevicefromwhitelist", "--addresstype", "public"]))
        XCTAssertThrowsError(try Command(arguments: ["removedevicefromwhitelist", "--addresstype", "public", "--address"]))
    }
    
    func testSetAdvertiseParameter() {
        
        do {
            /*
             [2006] Opcode: 0x2006 (OGF: 0x08    OCF: 0x06)
             Parameter Length: 15 (0x0F)
             Advertising Interval Min: 0x0014 (12.5ms)
             Advertising Interval Max: 0x001E (18.75ms)
             Advertising Type: 0x01 - Connectable directed advertising (ADV_DIRECT_IND)
             Own Address Type: Random
             Direct Address Type: Public
             Direct Address: (null)
             Advertising Channel Map: 0x01
             Advertising Filter Policy: 0x00 - Allow Scan Request from Any, Allow Connect Request from Any
             */
            let arguments = [/* ".build/debug/hcitool", */ "setadvertisingparameters", "--intervalmin", "20", "--intervalmax", "30", "--type",
                                                           "directed", "--ownaddresstype", "random", "--peeraddresstype", "public", "--peeraddress",
                                                           "54:39:A3:47:D8:77", "--channelmap", "channel37", "--filterpolicy", "any"]
            
            let command = try Command(arguments: arguments)
            
            guard case .lowEnergySetAdvertisingParameters = command
                else { XCTFail("Invalid type"); return }
            
        } catch { XCTFail("\(error)") }
    }
    
    func testSetRandomAddress() {
        
        do {
            /*
             [2005] Opcode: 0x2005 (OGF: 0x08    OCF: 0x05)
             Parameter Length: 6 (0x06)
             Random Address: 54:39:A3:47:D8:F0
             */
            let arguments = [/* ".build/debug/hcitool", */ "setrandomaddress", "--address", "54:39:A3:47:D8:F0"]
            
            let command = try Command(arguments: arguments)
            
            guard case let .lowEnergySetRandomAddress(commandValue) = command
                else { XCTFail("Invalid type"); return }
            
            XCTAssert(commandValue.address.rawValue == "54:39:A3:47:D8:F0")
            
        } catch { XCTFail("\(error)") }
        
        // invalid commands
        XCTAssertThrowsError(try Command(arguments: ["setrandomaddress", "--randomaddress"]))
    }
    
    func testLEScan() {
        
        // LE scan with specified duration
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "lescan", "--duration", "1000"]
            
            let command = try Command(arguments: arguments)
            
            guard case let .lowEnergyScan(commandValue) = command
                else { XCTFail("Invalid type"); return }
            
            XCTAssert(commandValue.duration == 1000)
            
        } catch { XCTFail("\(error)") }
        
        // LE scan with default duration
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "lescan"]
            
            let command = try Command(arguments: arguments)
            
            guard case let .lowEnergyScan(commandValue) = command
                else { XCTFail("Invalid type"); return }
            
            XCTAssert(commandValue.duration == LEScanCommand.default.duration)
            
        } catch { XCTFail("\(error)") }
        
        // invalid commands
        XCTAssertThrowsError(try Command(arguments: ["lescan", "--duration"]))
        XCTAssertThrowsError(try Command(arguments: ["lescan", "--duration", "abc"]))
    }
    
    func testLESetEventMask() {
        
        do {
            
            let arguments = [/* ".build/debug/hcitool", */ "seteventmask", "--event", "connectioncomplete", "--event", "advertisingreport"]
            
            let command = try Command(arguments: arguments)
            
            guard case let .lowEnergySetEventMask(commandValue) = command
                else { XCTFail("Invalid type"); return }
            
            XCTAssert(commandValue.events == [.connectionComplete, .advertisingReport])
            
        } catch { XCTFail("\(error)") }
    }
}
