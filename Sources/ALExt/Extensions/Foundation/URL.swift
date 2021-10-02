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

// MARK: Properties

public extension URL {
	/// SwifterSwift: Dictionary of the URL's query parameters.
	var queryParameters: [String: String]? {
		guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
			  let queryItems = components.queryItems else { return nil }
		
		var items: [String: String] = [:]
		
		for queryItem in queryItems {
			items[queryItem.name] = queryItem.value
		}
		
		return items
	}
}

// MARK: Initializers

public extension URL {
	/**
	 SwifterSwift: Initializes a forced unwrapped `URL` from string. Can potentially crash if string is invalid.
	 - Parameter unsafeString: The URL string used to initialize the `URL`object.
	 */
	init(unsafeString: String) {
		self.init(string: unsafeString)!
	}
}

// MARK: Methods

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
	
	/// SwifterSwift: URL with appending query parameters.
	///
	///		let url = URL(string: "https://google.com")!
	///		let param = ["q": "Swifter Swift"]
	///		url.appendingQueryParameters(params) -> "https://google.com?q=Swifter%20Swift"
	///
	/// - Parameter parameters: parameters dictionary.
	/// - Returns: URL with appending given query parameters.
	func appendingQueryParameters(_ parameters: [String: String]) -> URL {
		var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
		urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
			.map { URLQueryItem(name: $0, value: $1) }
		return urlComponents.url!
	}
	
	/// SwifterSwift: Append query parameters to URL.
	///
	///		var url = URL(string: "https://google.com")!
	///		let param = ["q": "Swifter Swift"]
	///		url.appendQueryParameters(params)
	///		print(url) // prints "https://google.com?q=Swifter%20Swift"
	///
	/// - Parameter parameters: parameters dictionary.
	mutating func appendQueryParameters(_ parameters: [String: String]) {
		self = appendingQueryParameters(parameters)
	}
	
	/// SwifterSwift: Get value of a query key.
	///
	///    var url = URL(string: "https://google.com?code=12345")!
	///    queryValue(for: "code") -> "12345"
	///
	/// - Parameter key: The key of a query value.
	func queryValue(for key: String) -> String? {
		return URLComponents(string: absoluteString)?
			.queryItems?
			.first(where: { $0.name == key })?
			.value
	}
	
	/// SwifterSwift: Remove all the path components from the URL.
	///
	///        var url = URL(string: "https://domain.com/path/other")!
	///        url.deleteAllPathComponents()
	///        print(url) // prints "https://domain.com/"
	mutating func deleteAllPathComponents() {
		for _ in 0..<pathComponents.count - 1 {
			deleteLastPathComponent()
		}
	}
	
	
}
