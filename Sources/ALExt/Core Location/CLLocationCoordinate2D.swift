// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// CLLocationCoordinate2D.swift
// Created by Alexander Lester on 4/30/20.
//

import Foundation
import CoreLocation

public extension CLLocationCoordinate2D {
	func toPlacemark() -> MKPlacemark { return MKPlacemark(coordinate: self) }
	func toMapItem() -> MKMapItem { return MKMapItem(placemark: MKPlacemark(coordinate: self)) }
}
