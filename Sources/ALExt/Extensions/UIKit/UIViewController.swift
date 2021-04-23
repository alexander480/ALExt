// ---------------------------------------
//                  __ __
// .---.-.--.--.--.|  |  |.--.--.--.---.-.
// |  _  |  |  |  ||  |  ||  |  |  |  _  |
// |___._|________||__|__||________|___._|
//
// ---------------------------------------
//
// UIViewController.swift
// Created by Alexander Lester on 4/30/20.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

@available(iOS 10.0, *)

public extension UIViewController {
	
	// MARK: Present UIAlertViewController
	
	func presentAlert(Title: String, Message: String?, Actions: [UIAlertAction]?) {
		let alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
		if let actions = Actions { for action in actions { alert.addAction(action) } }
		else { alert.addAction(UIAlertAction(title: "Okay", style: .cancel) { (action) in alert.dismiss(animated: true, completion: nil) }) }
		self.present(alert, animated: true, completion: nil)
	}
	
	// MARK: Present Loading Modal
	
	func loadingAlert() -> UIAlertController {
		let alert = UIAlertController(title: nil, message: "Please Wait", preferredStyle: .alert)

		let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
		loadingIndicator.hidesWhenStopped = true
		loadingIndicator.style = UIActivityIndicatorView.Style.gray
		loadingIndicator.startAnimating()

		alert.view.addSubview(loadingIndicator)
		
		return alert
	}
	
	// MARK: Present Toast Notification
	
	func presentToast(message : String, font: UIFont?, toastColor: UIColor = UIColor.white, toastBackground: UIColor = UIColor.black) {
		let font = font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
		
        let toastLabel = UILabel()
			toastLabel.textColor = toastColor
			toastLabel.font = font
			toastLabel.textAlignment = .center
			toastLabel.text = message
			toastLabel.alpha = 0.0
			toastLabel.layer.cornerRadius = 6
			toastLabel.backgroundColor = toastBackground

			toastLabel.clipsToBounds  =  true

        let toastWidth: CGFloat = toastLabel.intrinsicContentSize.width + 16
        let toastHeight: CGFloat = 32
        
        toastLabel.frame = CGRect(x: self.view.frame.width / 2 - (toastWidth / 2),
                                  y: self.view.frame.height - (toastHeight * 3),
                                  width: toastWidth, height: toastHeight)
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1.5, delay: 0.25, options: .autoreverse, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
	
	// MARK: Navigate To Location Settings
	
	func presentEnableLocationServicesAlert() {
		let alert = UIAlertController(title: "Please Enable Location Services", message: "Location services are required for using Pool. Please navigate to settings to enable.", preferredStyle: .alert)
		let takeMeThereAction = UIAlertAction(title: "Take Me There", style: .default) { (action) in
			alert.dismiss(animated: true) {
				guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { print("[ERROR] Unable To Validate UIApplication.openSettingsURLString."); return }
				UIApplication.shared.open(settingsURL)
			}
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in alert.dismiss(animated: true, completion: nil) }
		
		alert.addAction(takeMeThereAction)
		alert.addAction(cancelAction)
		
		self.present(alert, animated: true, completion: nil)
	}
	
	// MARK: Dismiss Keyboard When Tapped
	
	@objc func dismissKeyboard(_ sender: UITapGestureRecognizer) { view.endEditing(true) }
	
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
	
	// MARK: Present Interstatial Ad
	/*
	#if canImport(GoogleMobileAds)
	func present(Interstatial: GADInterstitial) {
		if Interstatial.isReady { Interstatial.present(fromRootViewController: self) }
		else { print("Ad wasn't ready") }
	}
	*/
}

// MARK: SwifterSwift Extensions

// MARK: - Properties
public extension UIViewController {

    /// SwifterSwift: Check if ViewController is onscreen and not hidden.
    var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return isViewLoaded && view.window != nil
    }

}

// MARK: - Methods
public extension UIViewController {

    /// SwifterSwift: Assign as listener to notification.
    ///
    /// - Parameters:
    ///   - name: notification name.
    ///   - selector: selector to run with notified.
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    /// SwifterSwift: Unassign as listener to notification.
    ///
    /// - Parameter name: notification name.
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }

    /// SwifterSwift: Unassign as listener from all notifications.
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    /// SwifterSwift: Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert
    ///
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - buttonTitles: (Optional)list of button titles for the alert. Default button i.e "OK" will be shown if this paramter is nil
    ///   - highlightedButtonIndex: (Optional) index of the button from buttonTitles that should be highlighted. If this parameter is nil no button will be highlighted
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument
    /// - Returns: UIAlertController object (discardable).
    @discardableResult
    func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }

        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }

    /// SwifterSwift: Helper method to add a UIViewController as a childViewController.
    ///
    /// - Parameters:
    ///   - child: the view controller to add as a child
    ///   - containerView: the containerView for the child viewcontroller's root view.
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }

    /// SwifterSwift: Helper method to remove a UIViewController from its parent.
    func removeViewAndControllerFromParentViewController() {
        guard parent != nil else { return }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }

    #if os(iOS)
    /// SwifterSwift: Helper method to present a UIViewController as a popover.
    ///
    /// - Parameters:
    ///   - popoverContent: the view controller to add as a popover.
    ///   - sourcePoint: the point in which to anchor the popover.
    ///   - size: the size of the popover. Default uses the popover preferredContentSize.
    ///   - delegate: the popover's presentationController delegate. Default is nil.
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///   - completion: The block to execute after the presentation finishes. Default is nil.
    func presentPopover(_ popoverContent: UIViewController, sourcePoint: CGPoint, size: CGSize? = nil, delegate: UIPopoverPresentationControllerDelegate? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        popoverContent.modalPresentationStyle = .popover

        if let size = size {
            popoverContent.preferredContentSize = size
        }

        if let popoverPresentationVC = popoverContent.popoverPresentationController {
            popoverPresentationVC.sourceView = view
            popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationVC.delegate = delegate
        }

        present(popoverContent, animated: animated, completion: completion)
    }
    #endif

}

#endif
