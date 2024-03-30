//
//  DateTimeFormatting.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation

public class DateTime: NSObject {
    public class func getDateStringFromDate(date: Date) -> String {
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "dd MMM yyyy"
        return stringFormatter.string(from: date)
    }
    
    public class func getDateStringFromDashedDateString(string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: string)
        
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "dd MMM yyyy"
        return stringFormatter.string(from: date!)
    }
}
