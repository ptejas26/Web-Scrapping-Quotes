//
//  ArticlesTableViewCell.swift
//  Jet2TT-Demo
//
//  Created by Tejas on 09/08/20.
//  Copyright © 2020 Tejas Patelia. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgViewProfile : UIImageView!
    @IBOutlet weak var lblUserName : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgViewProfile.addBorder()
		imgViewProfile.dropCorner()
    }

	public func updateCellDetails(model: QuoteModel?) {
		guard let model = model, let showName = model.showName else {return}
		lblUserName.text = showName.removeString(after: "#")
        let link = model.showLink ?? ""
		UIImageView().downloadImage(imageURL: link, completionHandler: { (image, error) in
			DispatchQueue.main.async { [weak self] in
				self?.imgViewProfile.image = image
			}
		})
    }

	public func setupCell() {
		lblUserName.numberOfLines = 0
		accessoryType = .disclosureIndicator
	}
    
    override func prepareForReuse() {
        imgViewProfile.image = nil
    }
}



