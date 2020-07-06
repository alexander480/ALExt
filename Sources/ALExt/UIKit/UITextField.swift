// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// UITextField.swift
// Created by Alexander Lester on 4/30/20.
//

#if canImport(UIKit)

import UIKit

public extension UITextField {
	@IBInspectable var cornerRadius: CGFloat = 0 { didSet { layer.cornerRadius = cornerRadius  } }
    @IBInspectable var shadowColor: CGColor = UIColor.black.cgColor { didSet { layer.shadowColor = shadowColor } }
    @IBInspectable var shadowOpacity: Float = 1.0 { didSet { layer.shadowOpacity = shadowOpacity } }
    @IBInspectable var shadowOffset: CGSize = CGSize.zero { didSet { layer.shadowOffset = shadowOffset } }
    @IBInspectable var shadowRadius: CGFloat = 10 { didSet { layer.shadowRadius = shadowRadius } }
    @IBInspectable var borderWidth: CGFloat { get { return layer.borderWidth } set { layer.borderWidth = newValue } }
    @IBInspectable var borderColor: UIColor? {
        get { if let color = layer.borderColor { return UIColor(cgColor: color) }; return nil }
        set { if let color = newValue { layer.borderColor = color.cgColor } else { layer.borderColor = nil } }
    }
}

#endif
