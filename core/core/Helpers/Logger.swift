//
//  Logger.swift
//  core
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import Foundation

public class Logger: NSObject {
    
    static let enableLoging = true
    
    public class func printLog(_ items: Any?) {
        if Logger.enableLoging {
            print(items ?? "=== printLog empty")
        }
    }
}
