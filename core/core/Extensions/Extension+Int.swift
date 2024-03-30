//
//  Extension+Int.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 14/02/24.
//

import Foundation

extension Int {
    // Number Formatting
    func f(_ type: IntFormatType = .number) -> String {
        switch type {
        case .number:
            return Number.stringWithNumber(amount: Double(self))
        case .currency:
            return String(format: "Rp %@", Number.stringWithNumber(amount: Double(self)))
        case .short:
            let num = abs(Double(self))
                let sign = (self < 0) ? "-" : ""

                switch num {
                case 1_000_000_000...:
                    var formatted = num / 1_000_000_000
                    formatted = formatted.reduceScale(to: 1)
                    return "\(sign)\(String(format: "%g", formatted))m"

                case 1_000_000...:
                    var formatted = num / 1_000_000
                    formatted = formatted.reduceScale(to: 1)
                    return "\(sign)\(String(format: "%g", formatted))jt"

                case 1_000...:
                    var formatted = num / 1_000
                    formatted = formatted.reduceScale(to: 1)
                    return "\(sign)\(String(format: "%g", formatted))rb"

                case 0...:
                    return "\(self)"

                default:
                    return "\(sign)\(self)"
                }
        }
    }
    
    
}
