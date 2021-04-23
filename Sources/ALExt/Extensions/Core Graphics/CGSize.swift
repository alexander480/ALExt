// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// CGSize.swift
// Created by Alexander Lester on 7/5/20.
//

#if canImport(CoreGraphics)

import CoreGraphics

public extension CGSize {
	func scale(toWidth: CGFloat) -> CGSize {
		let oldWidth = self.width
		let scaleFactor = toWidth / oldWidth

		let newHeight = CGFloat((self.height) * CGFloat(scaleFactor))
		let newWidth = oldWidth * scaleFactor
		
		return CGSize(width: newWidth, height: newHeight)
	}
}

#endif
