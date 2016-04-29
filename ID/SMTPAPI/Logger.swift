//
//  Logger.swift
//  SMTPAPI
//
//  Created by Scott Kawai on 10/17/15.
//  Copyright © 2015 SendGrid. All rights reserved.
//

import Foundation

public struct Logger {
    public static func log(type: String, message: String) {
        print("[\(type)] \(message)")
    }
    
    public static func warn(message: String) {
        Logger.log("**WARNING**", message: message)
    }
    
    public static func error(message: String) {
        Logger.log("**ERROR**", message: message)
    }
    
    public static func info(message: String) {
        Logger.log("INFO", message: message)
    }
}