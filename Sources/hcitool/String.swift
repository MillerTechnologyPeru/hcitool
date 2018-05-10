//
//  String.swift
//  hcitool
//
//  Created by Marco Estrella on 5/4/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

extension String {
    
    static var hexadecimalPrefix: String { return "0x" }
    
    func containsHexadecimalPrefix() -> Bool {
        
        return contains(String.hexadecimalPrefix)
    }
    
    func removeHexadecimalPrefix() -> String {
        
        guard contains(String.hexadecimalPrefix)
            else { return self }
        
        let suffixIndex = self.index(self.startIndex, offsetBy: 2)
        
        return String(self[suffixIndex...])
    }
    
    /// Creates a string representing the given value in base 10, or some other
    /// specified base.
    ///
    /// - Parameters:
    ///   - value: The UInt128 value to convert to a string.
    ///   - radix: The base to use for the string representation. `radix` must be
    ///     at least 2 and at most 36. The default is 10.
    ///   - uppercase: Pass `true` to use uppercase letters to represent numerals
    ///     or `false` to use lowercase letters. The default is `false`.
    public init(_ value: UInt128, radix: Int = 10, uppercase: Bool = false) {
        self = value._valueToString(radix: radix, uppercase: uppercase)
    }
}
