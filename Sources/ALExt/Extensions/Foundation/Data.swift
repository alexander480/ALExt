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

#if canImport(Foundation)
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

// MARK: SwifterSwift Extensions

// MARK: - Properties
public extension Data {

    /// SwifterSwift: Return data as an array of bytes.
    var bytes: [UInt8] {
        // http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
        return [UInt8](self)
    }

}

// MARK: - Methods
public extension Data {

    /// SwifterSwift: String by encoding Data using the given encoding (if applicable).
    ///
    /// - Parameter encoding: encoding.
    /// - Returns: String by encoding Data using the given encoding (if applicable).
    func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }

    /// SwifterSwift: Returns a Foundation object from given JSON data.
    ///
    /// - Parameter options: Options for reading the JSON data and creating the Foundation object.
    ///
    ///   For possible values, see `JSONSerialization.ReadingOptions`.
    /// - Returns: A Foundation object from the JSON data in the receiver, or `nil` if an error occurs.
    /// - Throws: An `NSError` if the receiver does not represent a valid JSON object.
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }

}

#endif

