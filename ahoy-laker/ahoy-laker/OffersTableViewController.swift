//
//  OffersTableViewController.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 6/21/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit

class OffersTableViewController: UITableViewController
{
	var json : NSMutableArray = []
	
	override func viewWillAppear(animated: Bool)
	{
		super.viewWillAppear(true)
		self.navigationController!.navigationBar.barTintColor = UIColor(red: (238/255), green: (101/255), blue: (69/255), alpha: 1)
		self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
		self.tabBarController?.title = "Offers"
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.tableView.rowHeight = 150
		let api = AHAPIReference()
		let data = api.getJSON("organizations")
		do
		{
			let orgs = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSMutableArray
			for org in orgs
			{
				let type = org["org_type"] as? Int
				if type < 2 || type > 2
				{
					json.addObject(org)
				}
			}
		}
		catch
		{
			print("JSON Error")
		}
		UIApplication.sharedApplication().networkActivityIndicatorVisible = false
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return json.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> OffersTableViewCell
	{
		let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! OffersTableViewCell
		let index = indexPath.row
		cell.orgTitle.text = json[index]["name"] as? String
		cell.orgID = json[index]["id"] as! Int
		return cell
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
		let cellSelected = sender as! OffersTableViewCell
		let newController = segue.destinationViewController as! OffersDetailTableViewController
		newController.orgID = cellSelected.orgID
		newController.orgTitle = cellSelected.orgTitle.text!
	}
}
