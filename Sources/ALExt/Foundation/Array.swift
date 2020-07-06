// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// Array.swift
// Created by Alexander Lester on 4/30/20.
//

import Foundation

public extension Array {
	func random() -> Array {
		var buf = self
		var last = buf.count - 1
		
		while(last > 0) {
			let rand = Int(arc4random_uniform(UInt32(last)))
			buf.swapAt(last, rand)
			last -= 1
		}
		
		return buf
	}
}
