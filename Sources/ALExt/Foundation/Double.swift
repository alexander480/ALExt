// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// Double.swift
// Created by Alexander Lester on 4/30/20.
//

import Foundation

public extension Double {
	func roundTo(_ place: Int) -> Double {
        let divisor = pow(10.0, Double(place))
        return (self * divisor).rounded() / divisor
    }
	
    func toCurrencyString() -> String {
        let divisor = pow(10.0, Double(2))
		let rounded = ((self * divisor).rounded() / divisor)
		
		let roundedStrComponents = String(describing: rounded).components(separatedBy: ".")
		
		let wholeNumStrComponent = String(describing: roundedStrComponents[0])
		var roundedDecimalStr = String(describing: roundedStrComponents[1])
		
		while roundedDecimalStr.count < 2 { roundedDecimalStr.append("0") }
		
        return "$" + wholeNumStrComponent + "." + roundedDecimalStr
    }
}
