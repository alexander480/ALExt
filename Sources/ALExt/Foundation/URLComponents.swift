// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// URLComponents.swift
// Created by Alexander Lester on 7/5/20.
//

import Foundation

public extension URLComponents {
    func createRequest(queryItems: [URLQueryItem]?, headers: [String: String]?) -> URLRequest {
        var url = self
        if let qItems = queryItems { url.queryItems = qItems }
        
        var req = URLRequest(url: url.url!)
        if let h = headers { for key in h.keys { req.setValue(h[key], forHTTPHeaderField: key) } }
        
        return req
    }
}
