//
//  MainViewController.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 5/30/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
	
	override func viewWillAppear(animated: Bool)
	{
		super.viewWillAppear(true)
		self.navigationController!.navigationBar.barTintColor = UIColor(red: 0.231, green: 0.565, blue: 0.808, alpha: 1)
		self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		if (segue.identifier == "services")
		{
			if let controller = segue.destinationViewController as? TabBarController
			{
				controller.initialIndex = 0
			}
		}
		else if (segue.identifier == "food")
		{
			if let controller = segue.destinationViewController as? TabBarController
			{
				controller.initialIndex = 1
			}
		}
		else if (segue.identifier == "offers")
		{
			if let controller = segue.destinationViewController as? TabBarController
			{
				controller.initialIndex = 2
			}
		}
	}
}
