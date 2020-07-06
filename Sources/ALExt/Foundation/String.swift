// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// String.swift
// Created by Alexander Lester on 4/30/20.
//

import Foundation

public extension String {
	
	func toURL() -> URL? { if let url = URL(string: self) { return url } else { return nil } }
	
	// Convert AM/PM Time To 24 Hour
	func getMilitaryTime() -> String {
		let dateFormatter = DateFormatter()
			
		dateFormatter.dateFormat = "h:mm a"
		let formattedDate = dateFormatter.date(from: self)!
			
		dateFormatter.dateFormat = "HH:mm:ss"
		let dateString = dateFormatter.string(from: formattedDate)
		
		return dateString
	}
	
    func truncate(length: Int) -> String {
		if self.count > length { return String(self.prefix(length)) }
		else { return self }
	}
	
	func parseAddress() -> String {
		let strArr = self.components(separatedBy: ",")
		return strArr[0]
	}
}
