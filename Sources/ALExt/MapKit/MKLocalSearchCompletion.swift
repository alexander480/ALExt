// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// MKLocalSearchCompletion.swift
// Created by Alexander Lester on 4/30/20.
//

import Foundation
import MapKit

public extension MKLocalSearchCompletion {
	func toCoordinates(completion: @escaping (CLLocationCoordinate2D?) -> ()) {
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString("\(self.title), \(self.subtitle)") { placemarks, error in
			if let location = placemarks?.first?.location { completion(location.coordinate) }
			else if let err = error { print("[ERROR] Unable To Convert MKLocalSearchCompletion Into CLLocationCoordinate2D. [MESSAGE] \(err.localizedDescription)"); completion(nil) }
		}
	}
}
