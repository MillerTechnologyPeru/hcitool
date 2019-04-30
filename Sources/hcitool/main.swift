
import Foundation
import Bluetooth

#if os(Linux)
import BluetoothLinux
#elseif os(macOS)
import BluetoothDarwin
import IOBluetooth
#endif

func run <T: BluetoothHostControllerInterface> (arguments: [String] = CommandLine.arguments, controller: T?) throws {
    
    //  first argument is always the current directory
    let arguments = Array(arguments.dropFirst())
    
    guard let controller = controller
        else { throw CommandError.bluetoothUnavailible }
    
    print("Bluetooth Controller: \(controller.address)")
    
    let command = try Command(arguments: arguments)
    
    try command.execute(controller: controller)
}

do { try run(controller: HostController.default) }

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
