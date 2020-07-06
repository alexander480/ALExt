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

#if canImport(CoreLocation)

import Foundation
import CoreLocation

public extension CLLocation {
    
	func inMileRadius(ofLocation: CLLocation) -> Bool {
		let distance = self.distance(from: ofLocation)
		print("[DISTANCE] \(distance)")
		if distance <= 1609 { return true }
		else { return false }
	}
    
    /// SwifterSwift: Calculate the half-way point along a great circle path between the two points.
    ///
    /// - Parameters:
    ///   - start: Start location.
    ///   - end: End location.
    /// - Returns: Location that represents the half-way point.
    
    static func midLocation(start: CLLocation, end: CLLocation) -> CLLocation {
        let lat1 = Double.pi * start.coordinate.latitude / 180.0
        let long1 = Double.pi * start.coordinate.longitude / 180.0
        let lat2 = Double.pi * end.coordinate.latitude / 180.0
        let long2 = Double.pi * end.coordinate.longitude / 180.0

        // Formula
        //    Bx = cos φ2 ⋅ cos Δλ
        //    By = cos φ2 ⋅ sin Δλ
        //    φm = atan2( sin φ1 + sin φ2, √(cos φ1 + Bx)² + By² )
        //    λm = λ1 + atan2(By, cos(φ1)+Bx)
        // Source: http://www.movable-type.co.uk/scripts/latlong.html
        let bxLoc = cos(lat2) * cos(long2 - long1)
        let byLoc = cos(lat2) * sin(long2 - long1)
        let mlat = atan2(sin(lat1) + sin(lat2), sqrt((cos(lat1) + bxLoc) * (cos(lat1) + bxLoc) + (byLoc * byLoc)))
        let mlong = (long1) + atan2(byLoc, cos(lat1) + bxLoc)

        return CLLocation(latitude: (mlat * 180 / Double.pi), longitude: (mlong * 180 / Double.pi))
    }

    /// SwifterSwift: Calculate the half-way point along a great circle path between self and another points.
    ///
    /// - Parameter point: End location.
    /// - Returns: Location that represents the half-way point.
    func midLocation(to point: CLLocation) -> CLLocation {
        return CLLocation.midLocation(start: self, end: point)
    }
}

#endif
