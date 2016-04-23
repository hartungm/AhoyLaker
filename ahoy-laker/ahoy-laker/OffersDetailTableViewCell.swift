//
//  OffersDetailTableViewCell.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 6/21/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit

class OffersDetailTableViewCell: UITableViewCell
{
//	@IBOutlet weak var getCouponCodeButton: UIButton!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var promoDetailLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	var offerID = 0
	var orgID = 0
	var couponCode = ""
}
