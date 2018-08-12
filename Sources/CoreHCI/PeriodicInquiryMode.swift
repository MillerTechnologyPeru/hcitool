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
    
    public typealias MaxDuration = HCIPeriodicInquiryMode.MaxDuration
    public typealias MinDuration = HCIPeriodicInquiryMode.MinDuration
    public typealias LAP = HCIPeriodicInquiryMode.LAP
    public typealias Duration = HCIPeriodicInquiryMode.Duration
    public typealias Responses = HCIPeriodicInquiryMode.Responses
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .periodicInquiryMode
    
    public let maxDuration: MaxDuration
    
    public let minDuration: MinDuration
    
    public let lap: LAP
    
    public let duration: Duration
    
    public let responses: Responses
    
    // MARK: - Initialization
    
    public init(maxDuration: MaxDuration,
                minDuration: MinDuration,
                lap: LAP,
                duration: Duration,
                responses: Responses) {
        
        self.maxDuration = maxDuration
        self.minDuration = minDuration
        self.lap = lap
        self.duration = duration
        self.responses = responses
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
        guard let maxDurationString = parameters.first(where: { $0.option == .maxDuration })?.value
            else { throw CommandError.optionMissingValue(Option.maxDuration.rawValue) }
        
        guard let maxDurationValue = UInt16(commandLine: maxDurationString), let maxDuration = MaxDuration(rawValue: maxDurationValue)
            else { throw CommandError.invalidOptionValue(option: Option.maxDuration.rawValue, value: maxDurationString) }
        
        self.maxDuration = maxDuration
        
        guard let minDurationString = parameters.first(where: { $0.option == .minDuration })?.value
            else { throw CommandError.optionMissingValue(Option.minDuration.rawValue) }
        
        guard let minDurationValue = UInt16(commandLine: minDurationString), let minDuration = MinDuration(rawValue: minDurationValue)
            else { throw CommandError.invalidOptionValue(option: Option.minDuration.rawValue, value: minDurationString) }
        
        self.minDuration = minDuration
        
        guard let lapString = parameters.first(where: { $0.option == .lap })?.value
            else { throw CommandError.optionMissingValue(Option.lap.rawValue) }
        
        guard let lapValue = UInt32(commandLine: lapString), let lap = LAP(rawValue: UInt24(lapValue))
            else { throw CommandError.invalidOptionValue(option: Option.lap.rawValue, value: lapString) }
        
        self.lap = lap
        
        guard let durationString = parameters.first(where: { $0.option == .duration })?.value
            else { throw CommandError.optionMissingValue(Option.duration.rawValue) }
        
        guard let durationValue = UInt8(commandLine: durationString), let duration = Duration(rawValue: durationValue)
            else { throw CommandError.invalidOptionValue(option: Option.duration.rawValue, value: durationString) }
        
        self.duration = duration
        
        guard let responsesString = parameters.first(where: { $0.option == .responses })?.value
            else { throw CommandError.optionMissingValue(Option.responses.rawValue) }
        
        guard let responsesValue = UInt8(commandLine: responsesString)
            else { throw CommandError.invalidOptionValue(option: Option.responses.rawValue, value: responsesString) }
        
        let responses = Responses(rawValue: responsesValue)
        
        self.responses = responses
    }
    
    // MARK: - Methods
    
    public func execute <Controller: BluetoothHostControllerInterface> (controller: Controller) throws {
        
        try controller.periodicInquiryMode(maxDuration: maxDuration,
                                           minDuration: minDuration,
                                           lap: lap,
                                           length: duration,
                                           responses: responses,
                                           timeout: 99999)
    }
}

public extension PeriodicInquiryModeCommand {
    
    public enum Option: String, OptionProtocol {
        
        case maxDuration = "maxperiodduration"
        case minDuration = "minperiodduration"
        case lap = "lap"
        case duration = "duration"
        case responses = "responses"
        
        public static let all: Set<Option> = [.maxDuration, .minDuration, .lap, .duration, .responses]
    }
}
