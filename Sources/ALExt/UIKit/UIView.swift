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

import Foundation
import UIKit

public extension UIView {
    
    // MARK: Border
	
    @IBInspectable var borderColor: UIColor? {
		get { if let color = layer.borderColor { return UIColor(cgColor: color) } else { return nil } }
        set { layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
	// MARK: Shadow
	
	@IBInspectable var shadowColor: UIColor? {
		get { if let color = layer.shadowColor { return UIColor(cgColor: color) } else { return nil } }
		set { layer.shadowColor = newValue?.cgColor ?? UIColor.black.cgColor }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set { layer.shadowOpacity = newValue }
        get { return layer.shadowOpacity }
    }

    @IBInspectable var shadowOffset: CGPoint {
		set { layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y) }
		get { return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height) }
	}
    
    @IBInspectable var shadowRadius: CGFloat {
		set { layer.shadowRadius = newValue }
		get { return layer.shadowRadius }
	}
	
	// MARK: Frame
	
	@IBInspectable var padding: CGFloat {
		set { self.layer.frame.inset(by: UIEdgeInsets(top: newValue, left: newValue, bottom: newValue, right: newValue)) }
		get { return CGFloat(self.layer.frame.minX - self.layer.frame.maxX) }
	}

	@IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
		set { layer.cornerRadius = newValue; layer.masksToBounds = newValue > 0 }
    }
	
	@IBInspectable var circular: Bool {
		set { self.layer.cornerRadius = (self.frame.size.width / 2); self.clipsToBounds = true }
		get { if self.layer.cornerRadius == (self.frame.size.width / 2) { return true } else { return false } }
	}
	
	// MARK: Animation
	
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

}

// MARK: Extension To Create UIView Programmatically From .xib
// See Article: https://medium.com/macoclock/swift-extensions-to-speed-up-your-ios-development-dccc00c72604

public extension UIView {
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
}

// MARK: Extensions To Make Programmatically Adding Constraints Easier
// See Article: https://medium.com/macoclock/swift-extensions-to-speed-up-your-ios-development-dccc00c72604
// More Specifically: https://gist.github.com/Shubham0812/f8bb0477f23e356c553a5cc5ce2e4d09/raw/25cb9037b56408765c107e4ffdfcdc6cd7afb961/ViewControllerAlternate.swift

public extension UIView {
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
