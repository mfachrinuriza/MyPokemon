//
//  Formatting.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation

class Number: NSObject {
    class func stringWithNumber(amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.locale = Locale(identifier: "id")
        formatter.maximumFractionDigits = 0

        let formattedString = formatter.string(for: amount)
        return formattedString!
    }
    
    class func minusToPlus(amount: Double) -> Double {
        if amount < 0 {
            return -(amount)
        } else {
            return amount
        }
    }
    
    class func roundToDecimal(decimal: Double, fractionDigits: Int) -> String {
        return String(format: "%.\(fractionDigits)f", decimal)
    }
}
