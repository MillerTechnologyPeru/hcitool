
import Foundation
import Rainbow
import Bluetooth

#if os(Linux)
import BluetoothLinux
#elseif os(macOS)
import BluetoothDarwin
import IOBluetooth
#endif

func run(arguments: [String] = CommandLine.arguments) throws {
    
    //  first argument is always the current directory
    let arguments = Array(arguments.dropFirst())
    
    guard let controller = HostController.default
        else { throw CommandError.bluetoothUnavailible }
    
    print("Bluetooth Controller: \(controller.address)")
    
    let command = try Command(arguments: arguments)
    
    try command.execute(controller: controller)
}

do { try run() }

catch {
    print("\(error)")
    exit(1)
}
