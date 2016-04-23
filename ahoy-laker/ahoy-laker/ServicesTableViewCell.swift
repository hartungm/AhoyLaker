//
//  ServicesTableViewCell.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 5/31/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ServicesTableViewCell: PFTableViewCell
{
	@IBOutlet weak var titleLabel: UILabel!
	var url: String = ""
	var type: String = ""
	var childKey: String = ""
}
