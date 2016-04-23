//
//  CafeTableViewCell.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 6/6/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit

class CafeTableViewCell: UITableViewCell
{
	@IBOutlet weak var cafeTitle: UILabel!
	@IBOutlet weak var cafeLocation: UILabel!
	@IBOutlet weak var cafeHours: UILabel!
	var cafeID : Int = 0
	var orgID : Int = 0
}
