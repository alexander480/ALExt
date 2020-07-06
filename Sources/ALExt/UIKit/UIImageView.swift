// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// UIImageView.swift
// Created by Alexander Lester on 4/30/20.
//

#if canImport(UIKit)

import UIKit

public extension UIImageView {
	@IBInspectable var cornerRadius: CGFloat = CGFloat.init(exactly: NSNumber(value: 1))! { didSet { layer.cornerRadius = cornerRadius } }
    @IBInspectable var shadowColor: CGColor = UIColor.black.cgColor { didSet { layer.shadowColor = shadowColor } }
    @IBInspectable var shadowOpacity: Float = 1.0 { didSet { layer.shadowOpacity = shadowOpacity } }
    @IBInspectable var shadowOffset: CGSize = CGSize.zero { didSet { layer.shadowOffset = shadowOffset } }
    @IBInspectable var shadowRadius: CGFloat = 10 { didSet { layer.shadowRadius = shadowRadius } }
    @IBInspectable var borderWidth: CGFloat { get { return layer.borderWidth } set { layer.borderWidth = newValue } }
    @IBInspectable var borderColor: UIColor? {
        get { if let color = layer.borderColor { return UIColor(cgColor: color) }; return nil }
        set { if let color = newValue { layer.borderColor = color.cgColor } else { layer.borderColor = nil } }
    }
	
	func blur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
			blurView.frame = self.bounds
			blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		
        self.addSubview(blurView)
    }
}

/*
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func imageFrom(urlString: String) {
        if let url = URL(string: urlString) {
            self.image = nil
            if let cachedImage = imageCache.object(forKey: urlString as NSString) { self.image = cachedImage; return }
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
                if let err = error?.localizedDescription { print(err); return }
                DispatchQueue.main.async(execute: { () -> Void in if let image = UIImage(data: data!) { imageCache.setObject(image, forKey: urlString as NSString); self.image = image } })
            }).resume()
        }
    }
    
    func blur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurView)
    }
}
*/

#endif
