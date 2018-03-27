
import Foundation
import Rainbow
import BluetoothLinux
import Bluetooth

let cli = CommandLine()

let command = StringOption(shortFlag: "c", longFlag: "command", required: true,
                            helpMessage: "Command.")

let timeInterval = DoubleOption(shortFlag: "t", longFlag: "time_interval",
                          helpMessage: "Time Interval.")

cli.addOptions(command, timeInterval)

cli.formatOutput = { s, type in
    var str: String
    switch(type) {
    case .error:
        str = s.red.bold
    case .optionFlag:
        str = s.green.underline
    case .optionHelp:
        str = s.blue
    default:
        str = s
    }
    return cli.defaultFormat(s: str, type: type)
}

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(1)
}

guard let commandValue = command.value else {
        print("Error command")
    exit(1)
    }

guard let controller = HostController.default
    else { print("No Bluetooth adapters found")
         exit(1)
}

print("Found Bluetooth adapter with device ID: \(controller.identifier)")

print("Address: \(controller.address)")

guard let command = Command(rawValue: commandValue)
    else { exit(1) }

switch command {
case .scan:
    LEScanTest(controller: controller, duration: 1000)
    break
default:
    break
}


