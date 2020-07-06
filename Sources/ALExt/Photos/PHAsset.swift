// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// PHAsset.swift
// Created by Alexander Lester on 7/5/20.
//

import Photos

public extension PHAsset {
	func size() -> CGSize { return CGSize(width: self.pixelWidth, height: self.pixelHeight) }
	func scaledSize(toFit width: CGFloat) -> CGSize { let oldSize = self.size(); return oldSize.scale(toFit: width) }
}

