// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// NSMutableAttributedString.swift
// Created by Alexander Lester on 4/30/20.
//

#if canImport(UIKit)

import UIKit

public extension NSMutableAttributedString {
	func add(Image: UIImage, WithOffset: CGFloat?) {
		let imageAttachment =  NSTextAttachment()
		imageAttachment.image = Image
		
		let fontHeight = self.height(withConstrainedWidth: 83.0) / 1.25
		
		let imageOffsetY:CGFloat = WithOffset ?? -4.0
		imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: fontHeight, height: fontHeight)
		
		let attachmentString = NSAttributedString(attachment: imageAttachment)
		self.append(attachmentString)
	}
	
	func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingBox.height)
    }
}

#endif
