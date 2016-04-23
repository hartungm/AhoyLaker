//
//  TabBarController.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 5/30/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController
{
	var initialIndex : Int = 1
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.selectedIndex = initialIndex
	}
}
