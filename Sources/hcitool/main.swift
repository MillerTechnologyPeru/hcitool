
import Foundation
import Bluetooth

#if os(Linux)
import BluetoothLinux
#elseif os(macOS)
import BluetoothDarwin
import IOBluetooth
#endif

func run(arguments: [String] = CommandLine.arguments) throws {
    
    guard let controller = HostController.default
        else { throw CommandError.bluetoothUnavailible }
    
    #if os(macOS)
    if controller.powerState != .on, controller.isPowerChangeSupported {
        do { try HostController.default?.setPowerState(false) }
        catch { print("Unable to set power state: \(error)") }
    }
    #elseif os(Linux)
    if try controller.deviceInformation().flags.contains(.up) == false {
        try controller.enable()
    }
    #endif
    
    //  first argument is always the current directory
    let arguments = Array(arguments.dropFirst())
    
    let address = try controller.readDeviceAddress()
    
    print("Bluetooth Controller: \(address)")
    
    let command = try Command(arguments: arguments)
    
    try command.execute(controller: controller)
}

do { try run() }

catch CommandError.noCommand {
    
    print("Error: Specify a command")
    #if swift(>=4.2)
    for command in CommandType.allCases {
        print(command.rawValue, "(\(command.name))")
    }
    #endif
    exit(1)
}
    
catch {
    print("Error: \(error)")
    exit(1)
}
