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
    public typealias Duration = HCIInquiry.Duration
    public typealias Responses = HCIInquiry.Responses
    
    // MARK: - Properties
    
    public static let commandType: CommandType = .inquiry
    
    public let lap: LAP
    
    public let duration: Duration
    
    public let responses: Responses
    
    // MARK: - Initialization
    
    public init(lap: LAP, duration: Duration, responses: Responses) {
        
        self.lap = lap
        self.duration = duration
        self.responses = responses
    }
    
    public init(parameters: [Parameter<Option>]) throws {
        
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
        
        print("Scanning for \(duration.seconds) seconds...")
        
        try controller.inquiry(lap: lap,
                               duration: duration,
                               responses: responses,
                               timeout: 15000,
                               foundDevice: { print($0.address) })
    }
}

public extension InquiryCommand {
    
    public enum Option: String, OptionProtocol {
        
        case lap = "lap"
        case duration = "duration"
        case responses = "responses"
        
        public static let all: Set<Option> = [.lap, .duration, .responses]
    }
}
