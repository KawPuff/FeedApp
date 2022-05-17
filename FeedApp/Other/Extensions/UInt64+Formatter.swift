//
//  UInt64+Formatter.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 17.05.2022.
//

import Foundation

extension UInt64 {
    
    var formatted: String {
        get {
            return format(number: self)
        }
    }
    
    private func format(number: UInt64) -> String {
        let newNum = Double(number)
        switch newNum {
        case 1_000_000...:
            let formatted = newNum / 1_000_000
            return String(format: "%g", formatted.reduceScale(to: 1)) + "m"
            
        case 1_000...:
            let formatted = newNum / 1_000
            return String(format: "%g", formatted.reduceScale(to: 1)) + "k"
            
        case 0...:
            return String(number)
            
        default:
            return "NaN"
        }
    
    }
    
}
extension Int64 {
    var formatted: String {
        get {
            return format(number: self)
        }
    }
    private func format(number: Int64) -> String {
        let symbol = number >= 0 ? "" : "-"
        let newNum = Double(number)
        switch newNum {
        case 1_000_000...:
            let formatted = newNum / 1_000_000
            return symbol + String(format: "%g", formatted.reduceScale(to: 1)) + "m"
            
        case 1_000...:
            let formatted = newNum / 1_000
            return symbol + String(format: "%g", formatted.reduceScale(to: 1)) + "k"
            
        case 0...:
            return symbol + String(number)
            
        default:
            return "NaN"
        }
    
    }
    
}
extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self
        let truncated = Double(Int(newDecimal))
        return truncated / multiplier
    }
}
