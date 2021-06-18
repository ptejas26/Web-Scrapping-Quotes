//
//  Extensions.swift
//  Web-Scrapping-Quotes
//
//  Created by Tejas Patelia on 17/06/21.
//

import Foundation
import UIKit

extension String {

	func removeString(after: String) -> String {
		guard !after.isEmpty else { return "" }
		let array = self.split(separator: Character(after))
		if !array.isEmpty {
			return String(array[0])
		}
		return ""
	}
}

extension UIView {
	func addBorder(width: CGFloat = 1.0, color: UIColor = .lightGray) {
		layer.borderWidth = width
		layer.borderColor = color.cgColor
	}

	func dropCorner(radius: CGFloat = 5.0) {
		layer.cornerRadius = radius
	}

}
