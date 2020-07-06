// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// URL.swift
// Created by Alexander Lester on 4/30/20.
//

import Foundation

public extension URL {
	func syncFetch() -> Data? {
		let semaphore = DispatchSemaphore(value: 0)
		var result: Data?
		
		let task = URLSession.shared.dataTask(with: self) {(data, response, error) in
			guard let data = data else { print("[ERROR] Could Not Fetch Data From API."); return }
			result = data
			semaphore.signal()
		}
		
		task.resume()
		semaphore.wait()
		
		return result
	}
}
