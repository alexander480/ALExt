//
//  ALPrint.swift
//  ALExt
//
//  Created by Alexander Lester on 4/22/21.
//  Copyright © 2021 Alexander Lester. All rights reserved.
//

import Foundation

public enum LogType {
    case info
    case success
    case warning
    case error
    case none
}

public func ALPrint(_ message: String, _ logType: LogType = .none) {
    switch logType {
        case .info:
            print("∆ [INFO] " + message)
        case .success:
            print("∆ [SUCCESS] " + message)
        case .warning:
            print("∆ [WARNING] " + message)
        case .error:
            print("∆ [ERROR] " + message)
        case .none:
            print("∆ " + message)
    }
}
