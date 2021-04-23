// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// CLLocationDistance.swift
// Created by Alexander Lester on 4/30/20.
//

#if canImport(CoreLocation)

import Foundation
import CoreLocation

public extension CLLocationDistance {
	func toMiles(_ rounded: Bool) -> Double {
		let miles = Double(self * 0.00062)
		if rounded { return miles.roundTo(2) } else { return miles }
	}
}

#endif
