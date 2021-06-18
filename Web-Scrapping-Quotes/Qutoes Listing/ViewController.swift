//
//  ViewController.swift
//  Web-Scrapping-Quotes
//
//  Created by Tejas Patelia on 17/06/21.
//

import UIKit
import Kanna
import Alamofire

struct QuoteModel {
	var showName : String?
	var showLink : String?
}

class ViewController: UIViewController {

	@IBOutlet weak var tableView : UITableView! {
		didSet {
			tableView.rowHeight = UITableView.automaticDimension
			tableView.estimatedRowHeight = 100
		}
	}

	var html : String = ""
	var quotes:[QuoteModel] = [QuoteModel]()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Quotes"
		fetchQuotesFromWebsite()
	}
}

//MARK: Web call

extension ViewController {

	func fetchQuotesFromWebsite() {
		APIManager.sharedInstance.getMethod { [weak self] (responseString) in

			self?.html = responseString
			self?.parseHTML(responseString)
		}
	}

	func parseHTML(_ html: String) {

		if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {

			for show in doc.css("div a img") {

				if (show["src"]?.contains("logo"))! {
					continue
				}
				if let text = show["alt"], let _ = show.parent?["href"], let imgSrc = show["src"] {

					let newText = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
					let showObj = QuoteModel(showName: newText, showLink: imgSrc)
					quotes.append(showObj)
				}
			}
			tableView.reloadData()
		}
	}
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return quotes.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCell") as? QuoteTableViewCell else {return UITableViewCell()}
		let showModel = quotes[indexPath.row]
		cell.setupCell()
		cell.updateCellDetails(model: showModel)
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		guard let url = quotes[indexPath.row].showLink, let urlNew = URL(string: url) else {return}
		BrowserHelper.sharedInstance.openURL(urlNew)
	}
}
