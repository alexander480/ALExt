// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// UIView.swift
// Created by Alexander Lester on 4/30/20.
//

#if canImport(UIKit)

import UIKit

@available(iOS 9.0, *)

public extension UIView {
    
    func addBorder(color: UIColor = .black, width: CGFloat = 2.0) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func addShadow(color: UIColor = .black, opacity: CGFloat = 2.0, offset: CGSize = CGSize(width: 2, height: 2), radius: CGFloat = 0, path: CGPath?) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = Float(opacity)
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        
        if let shadowPath = path { self.layer.shadowPath = shadowPath }
    }
    
    func addPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.layer.frame.inset(by: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }
    
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func toggleBlur(_ shouldBlur: Bool, style: UIBlurEffect.Style?) {
        let blurViews = self.subviews.filter{ $0 is UIVisualEffectView }
        
        if shouldBlur {
            let effect = UIBlurEffect(style: style ?? .dark)
            let blurView = UIVisualEffectView(effect: effect)
                blurView.frame = self.bounds
                blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.addSubview(blurView)
            self.sendSubviewToBack(blurView)
        }
        else {
            for view in blurViews { view.removeFromSuperview() }
        }
    }
    
    func makeCircular() {
        self.layer.cornerRadius = (self.frame.size.width / 2)
        self.clipsToBounds = true
    }
	
	func animateTo(frame: CGRect, withDuration duration: TimeInterval, completion: ((Bool) -> Void)? = nil) {
	  guard let _ = superview else {
		return
	  }
	  
	  let xScale = frame.size.width / self.frame.size.width
	  let yScale = frame.size.height / self.frame.size.height
	  let x = frame.origin.x + (self.frame.width * xScale) * self.layer.anchorPoint.x
	  let y = frame.origin.y + (self.frame.height * yScale) * self.layer.anchorPoint.y
	 
	  UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
		self.layer.position = CGPoint(x: x, y: y)
		self.transform = self.transform.scaledBy(x: xScale, y: yScale)
	  }, completion: completion)
	}
    
    func centerPoint(ForSize: CGSize) -> CGPoint {
        let xPoint = ((self.frame.size.width / 2) - (ForSize.width / 2))
        let yPoint = ((self.frame.size.height / 2) - (ForSize.height / 2))
        return CGPoint(x: xPoint, y: yPoint)
    }

    func displayToast(_ message: String, font: UIFont = UIFont().standard(), textColor: UIColor = UIColor.white, backgroundColor: UIColor = UIColor.black) {
        
        let toastLabel = UILabel()
            toastLabel.textColor = textColor
            toastLabel.font = font
            toastLabel.textAlignment = .center
            toastLabel.text = message
            toastLabel.alpha = 0.0
            toastLabel.layer.cornerRadius = 6
            toastLabel.backgroundColor = backgroundColor

            toastLabel.clipsToBounds  =  true

        let toastWidth: CGFloat = toastLabel.intrinsicContentSize.width + 16
        let toastHeight: CGFloat = 32
        
        toastLabel.frame = CGRect(x: self.frame.width / 2 - (toastWidth / 2),
                                  y: self.frame.height - (toastHeight * 3),
                                  width: toastWidth, height: toastHeight)
        
        self.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .autoreverse, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
    
    func removeGestureRecognizers() { if let recognizers = self.gestureRecognizers { for recognizer in recognizers { self.removeGestureRecognizer(recognizer) } } }
    
    // MARK: Extension To Create UIView Programmatically From .xib
    // See Article: https://medium.com/macoclock/swift-extensions-to-speed-up-your-ios-development-dccc00c72604
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)),
                                                                         owner: self, options: nil)?.first as? T else {
            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttachAll()
        return contentView
    }
    /// attaches all sides of the receiver to its parent view
    func layoutAttachAll(margin : CGFloat = 0.0) {
        let view = superview
        layoutAttachTop(to: view, margin: margin)
        layoutAttachBottom(to: view, margin: margin)
        layoutAttachLeading(to: view, margin: margin)
        layoutAttachTrailing(to: view, margin: margin)
    }

    /// attaches the top of the current view to the given view's top if it's a superview of the current view, or to it's bottom if it's not (assuming this is then a sibling view).
    /// if view is not provided, the current view's super view is used
    @discardableResult
    func layoutAttachTop(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = view == superview
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal,
                                            toItem: view, attribute: isSuperview ? .top : .bottom, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }

    /// attaches the bottom of the current view to the given view
    @discardableResult
    func layoutAttachBottom(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                                            toItem: view, attribute: isSuperview ? .bottom : .top, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
    /// attaches the leading edge of the current view to the given view
    @discardableResult
    func layoutAttachLeading(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal,
                                            toItem: view, attribute: isSuperview ? .leading : .trailing, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }

    /// attaches the trailing edge of the current view to the given view
    @discardableResult
    func layoutAttachTrailing(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal,
                                            toItem: view, attribute: isSuperview ? .trailing : .leading, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    // MARK: Extensions To Make Programmatically Adding Constraints Easier
    // See Article: https://medium.com/macoclock/swift-extensions-to-speed-up-your-ios-development-dccc00c72604
    // More Specifically: https://gist.github.com/Shubham0812/f8bb0477f23e356c553a5cc5ce2e4d09/raw/25cb9037b56408765c107e4ffdfcdc6cd7afb961/ViewControllerAlternate.swift
    
    struct AnchoredConstraints {
        var top, leading, bottom, trailing, width, height, centerX, centerY: NSLayoutConstraint?
    }
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero,
                size: CGSize = .zero, centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?,
                centerXOffset: CGFloat = 0, centerYOffset: CGFloat = 0) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        if let centerX = centerX {
            anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: centerX, constant: centerXOffset)
        }
        
        if let centerY = centerY {
            anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: centerY, constant: centerYOffset)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing,
         anchoredConstraints.width, anchoredConstraints.height,
         anchoredConstraints.centerX, anchoredConstraints.centerY].forEach{ $0?.isActive = true }
      
        return anchoredConstraints
    }
}

#endif
