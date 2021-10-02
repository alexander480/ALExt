// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// UIPanGestureRecognizer.swift
// Created by Alexander Lester on 7/5/20.
//

#if canImport(UIKit)

import UIKit

public enum PanDirection: Int {
    case Up
    case Down
    case Left
    case Right
    case None

    /// Returns true is the PanDirection is horizontal.
    public var isX: Bool { return self == .Left || self == .Right }
    
    /// Returns true if the PanDirection is vertical.
    public var isY: Bool { return self == .Up || self == .Down }
}

public extension UIPanGestureRecognizer {
    var direction: PanDirection? {
        let velocity = self.velocity(in: view)
        let vertical = abs(velocity.y) > abs(velocity.x)
        switch (vertical, velocity.x, velocity.y) {
            case (true, _, let y) where y < 0: return .Up
            case (true, _, let y) where y > 0: return .Down
            case (false, let x, _) where x > 0: return .Right
            case (false, let x, _) where x < 0: return .Left
            default: return .None
        }
    }
}

#endif
