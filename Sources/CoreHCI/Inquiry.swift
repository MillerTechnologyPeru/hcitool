//
//  Inquiry.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/25/18.
//
//

import Bluetooth
import Foundation

public struct InquiryCommand: ArgumentableCommand {
    
    public typealias LAP = HCIInquiry.LAP
    public typealias Length = HCIInquiry.Length
    public typealias Responses = HCIInquiry.Responses
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .inquiry
    
    public let lap: LAP
    
    public let length: Length
    
    public let responses: Responses
    
    // MARK: - Initialization
    
    public init(lap: LAP, length: Length, responses: Responses) {
        
        self.lap = lap
        self.length = length
        self.responses = responses
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let lapString = parameters.first(where: { $0.option == .lap })?.value
            else { throw CommandError.optionMissingValue(Option.lap.rawValue) }
        
        guard let lapValue = UInt32(commandLine: lapString), let lap = LAP(rawValue: UInt24(lapValue))
            else { throw CommandError.invalidOptionValue(option: Option.lap.rawValue, value: lapString) }
        
        self.lap = lap
        
        guard let lengthString = parameters.first(where: { $0.option == .length })?.value
            else { throw CommandError.optionMissingValue(Option.length.rawValue) }
        
        guard let lengthValue = UInt8(commandLine: lengthString), let length = Length(rawValue: lengthValue)
            else { throw CommandError.invalidOptionValue(option: Option.length.rawValue, value: lengthString) }
        
        guard let responsesString = parameters.first(where: { $0.option == .responses })?.value
            else { throw CommandError.optionMissingValue(Option.responses.rawValue) }
        
        guard let responsesValue = UInt8(commandLine: responsesString), let responses = Responses(rawValue: responsesValue)
            else { throw CommandError.invalidOptionValue(option: Option.responses.rawValue, value: lengthString) }
        
        self.length = length
        
        self.responses = responses
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        print("Scanning for \(length.seconds) seconds...")
        
        let startDate = Date()
        let endDate = startDate + length.seconds
        
        try controller.inquiry(lap: lap,
                               length: length,
                               responses: responses,
                               timeout: 99999,
                               shouldContinue: { Date() < endDate },
                               foundDevice: { print($0.address) })
    }
}

public extension InquiryCommand {
    
    public enum Option: String, OptionProtocol {
        
        case lap = "lap"
        case length = "length"
        case responses = "responses"
        
        public static let all: Set<Option> = [.lap, .length, .responses]
    }
}
