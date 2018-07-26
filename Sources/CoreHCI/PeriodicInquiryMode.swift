//
//  PeriodicInquiryMode.swift
//  hcitool
//
//  Created by Carlos Duclos on 7/26/18.
//
//

import Bluetooth
import Foundation

public struct PeriodicInquiryModeCommand: ArgumentableCommand {
    
    public typealias MaxPeriodLength = HCIPeriodicInquiryMode.MaxPeriodLength
    public typealias MinPeriodLength = HCIPeriodicInquiryMode.MinPeriodLength
    public typealias LAP = HCIPeriodicInquiryMode.LAP
    public typealias Length = HCIPeriodicInquiryMode.Length
    public typealias Responses = HCIPeriodicInquiryMode.Responses
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .periodicInquiryMode
    
    public let maxPeriodLength: MaxPeriodLength
    
    public let minPeriodLength: MinPeriodLength
    
    public let lap: LAP
    
    public let length: Length
    
    public let responses: Responses
    
    // MARK: - Initialization
    
    public init(maxPeriodLength: MaxPeriodLength,
                minPeriodLength: MinPeriodLength,
                lap: LAP,
                length: Length,
                responses: Responses) {
        
        self.maxPeriodLength = maxPeriodLength
        self.minPeriodLength = minPeriodLength
        self.lap = lap
        self.length = length
        self.responses = responses
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let maxPeriodLengthString = parameters.first(where: { $0.option == .maxPeriodLength })?.value
            else { throw CommandError.optionMissingValue(Option.maxPeriodLength.rawValue) }
        
        guard let maxPeriodLengthValue = UInt16(commandLine: maxPeriodLengthString), let maxPeriodLength = MaxPeriodLength(rawValue: maxPeriodLengthValue)
            else { throw CommandError.invalidOptionValue(option: Option.maxPeriodLength.rawValue, value: maxPeriodLengthString) }
        
        self.maxPeriodLength = maxPeriodLength
        
        guard let minPeriodLengthString = parameters.first(where: { $0.option == .minPeriodLength })?.value
            else { throw CommandError.optionMissingValue(Option.minPeriodLength.rawValue) }
        
        guard let minPeriodLengthValue = UInt16(commandLine: minPeriodLengthString), let minPeriodLength = MinPeriodLength(rawValue: minPeriodLengthValue)
            else { throw CommandError.invalidOptionValue(option: Option.minPeriodLength.rawValue, value: minPeriodLengthString) }
        
        self.minPeriodLength = minPeriodLength
        
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
        
        try controller.periodicInquiryMode(maxLength: maxPeriodLength,
                                           minLength: minPeriodLength,
                                           lap: lap,
                                           length: length,
                                           responses: responses,
                                           timeout: 99999)
    }
}

public extension PeriodicInquiryModeCommand {
    
    public enum Option: String, OptionProtocol {
        
        case maxPeriodLength = "maxperiodlength"
        case minPeriodLength = "minperiodlength"
        case lap = "lap"
        case length = "length"
        case responses = "responses"
        
        public static let all: Set<Option> = [.maxPeriodLength, .minPeriodLength, .lap, .length, .responses]
    }
}
