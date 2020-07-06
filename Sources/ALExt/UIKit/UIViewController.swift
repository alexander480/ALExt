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

#if canImport(UIKit)

import UIKit

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

#endif
