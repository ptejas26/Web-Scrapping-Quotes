//
//  APIManager.swift
//  Web-Scrapping-Quotes
//
//  Created by Tejas Patelia on 17/06/21.
//

import Foundation
import Alamofire

class APIManager : NSObject {
    
    static let sharedInstance = APIManager()
    
    let baseURL = "https://www.passiton.com/inspirational-quotes"
    
    func getMethod( completion: @escaping (String)-> Void){
        AF.request(baseURL).response { response in
            
            let str = String(data: response.data ?? Data(), encoding: .utf8)
            completion(str ?? "")
        }
    }
}

typealias ImageResponse = (UIImage?,Error?)->()

extension UIImageView {

	func downloadImage(imageURL: String, completionHandler: @escaping ImageResponse) {

		guard let url = URL(string: imageURL) else { return }
		let urlRequest = URLRequest(url: url)


		let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlresponse, error) in
			if error == nil {

				guard let imgData = data else{return}

				if let image = UIImage(data: imgData) {
					completionHandler(image,nil)
				}
			}else{
				completionHandler(nil,error)
			}
		}
		urlSession.resume()
	}
}

