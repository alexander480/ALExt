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

#if canImport(CoreLocation) && canImport(MapKit)

import Foundation
import CoreLocation
import MapKit

@available(OSX 10.12, *)
@available(iOS 10.0, *)

public extension CLLocationCoordinate2D {
    func toPlacemark() -> MKPlacemark { return MKPlacemark(coordinate: self) }
	func toMapItem() -> MKMapItem { return MKMapItem(placemark: MKPlacemark(coordinate: self)) }
}

#endif
