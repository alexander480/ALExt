//
//  Color.swift
//  
//
//  Created by Alexander Lester on 10/12/21.
//


#if canImport(SwiftUI)

import SwiftUI

public extension Color {
	convenience init?(_ hexString: String) {
		var hexStr = hexString
		if hexString.first == "#" { hexStr.removeFirst() }
		
		guard let hexInt = Int(hexStr, radix: 16) else {
			ALPrint("Failed To Convert Hex String Into Int.", .error);
			
			return nil
		}
		
		self.init(hex: hexInt)
	}
}

#endif
