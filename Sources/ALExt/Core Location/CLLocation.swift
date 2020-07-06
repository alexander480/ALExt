// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// CLLocation.swift
// Created by Alexander Lester on 4/30/20.
//

import Foundation
import CoreLocation

public extension CLLocation {
	func inMileRadius(ofLocation: CLLocation) -> Bool {
		let distance = self.distance(from: ofLocation)
		print("[DISTANCE] \(distance)")
		if distance <= 1609 { return true }
		else { return false }
	}
}
