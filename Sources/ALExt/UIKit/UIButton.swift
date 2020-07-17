// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// UIButton.swift
// Created by Alexander Lester on 4/30/20.
//

#if canImport(UIKit)

import UIKit

public extension UIButton {

	func setImageForAllStates(image: UIImage) {
		self.setImage(image, for: .normal)
		self.setImage(image, for: .selected)
		self.setImage(image, for: .highlighted)
		self.setImage(image, for: .disabled)
	}
	
	func setBackgroundImageForAllStates(image: UIImage) {
		self.setBackgroundImage(image, for: .normal)
		self.setBackgroundImage(image, for: .selected)
		self.setBackgroundImage(image, for: .highlighted)
		self.setBackgroundImage(image, for: .disabled)
	}
	
	func setTitleForAllStates(title: String) {
		self.setTitle(title, for: .normal)
		self.setTitle(title, for: .selected)
		self.setTitle(title, for: .highlighted)
		self.setTitle(title, for: .disabled)
	}
	
	func setAttributedTitleForAllStates(title: NSAttributedString) {
		self.setAttributedTitle(title, for: .normal)
		self.setAttributedTitle(title, for: .selected)
		self.setAttributedTitle(title, for: .highlighted)
		self.setAttributedTitle(title, for: .disabled)
	}
	
    @available(iOS 13.0, *)
    func setSFSymbol(iconName: String, size: CGFloat, weight: UIImage.SymbolWeight, scale: UIImage.SymbolScale, tintColor: UIColor, backgroundColor: UIColor) {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: size, weight: weight, scale: scale)
        let buttonImage = UIImage(systemName: iconName, withConfiguration: symbolConfiguration)
        self.setImage(buttonImage, for: .normal)
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
    }
	
	func centerTitleVertically(padding: CGFloat = 12.0) {
        guard let imageViewSize = self.imageView?.frame.size, let titleLabelSize = self.titleLabel?.frame.size else { return }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height) / 2,
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
    
    func addBlur(style: UIBlurEffect.Style) {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: style))
            blur.frame = self.bounds
            blur.isUserInteractionEnabled = false
        
        self.insertSubview(blur, at: 0)
        
        if let imageView = self.imageView {
            self.bringSubviewToFront(imageView)
        }
    }
}

#endif
