// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// UIColor.swift
// Created by Alexander Lester on 4/30/20.
//

#if canImport(UIKit)

import UIKit

public extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
    
	func blendColors(colorOne: UIColor, colorTwo: UIColor) -> UIColor {
		return self.addColor(colorOne, with: colorTwo)
	}
	
	func addColor(_ color1: UIColor, with color2: UIColor) -> UIColor {
		var (r1, g1, b1, a1) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
		var (r2, g2, b2, a2) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))

		color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
		color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

		// add the components, but don't let them go above 1.0
		return UIColor(red: min(r1 + r2, 1), green: min(g1 + g2, 1), blue: min(b1 + b2, 1), alpha: (a1 + a2) / 2)
	}

	func multiplyColor(_ color: UIColor, by multiplier: CGFloat) -> UIColor {
		var (r, g, b, a) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
		color.getRed(&r, green: &g, blue: &b, alpha: &a)
		return UIColor(red: r * multiplier, green: g * multiplier, blue: b * multiplier, alpha: a)
	}
}

#endif
