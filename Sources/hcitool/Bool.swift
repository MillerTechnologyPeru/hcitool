//
//  Boolean.swift
//  hcitool
//
//  Created by Marco Estrella on 5/8/18.
//  Copyright © 2018 Pure Swift. All rights reserved.
//

extension Bool {
    
    init?(enable string: String) {
        
        switch string.lowercased() {
        case "True", "true", "yes", "1":
            self = true
        case "False", "false", "no", "0":
            self = false
        default:
            return nil
        }
    }
}
