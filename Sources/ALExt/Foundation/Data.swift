// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// Data.swift
// Created by Alexander Lester on 4/30/20.
//

import Foundation

public extension Data {
	func parseFromJSON() -> [String] {
		var array = [String]()
		
		do {
			let json = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as! [[String: Any]]
			for result in json { if let rhymeWord = result["word"] as? String { array.append(rhymeWord) } }
		}
		catch { print("[ERROR] Could Not Parse JSON From Datamuse API.") }
		
		return array
	}
}
