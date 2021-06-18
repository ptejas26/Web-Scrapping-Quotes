//
//  BrowserHelper.swift
//  Web-Scrapping-Quotes
//
//  Created by Tejas Patelia on 17/06/21.
//

import Foundation
import UIKit

class BrowserHelper {
    
    private init(){}
    
    static let sharedInstance = BrowserHelper()
    
    func openURL(_ urlNew : URL){
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(urlNew, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(urlNew)
        }
    }
}
x
