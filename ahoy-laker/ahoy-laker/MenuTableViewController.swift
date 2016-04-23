//
//  MenuTableViewController.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 6/13/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController
{
	var diningTitle : String = ""
	var orgID : Int = 0
	var diningID : Int = 0
	var menusJSON : NSMutableArray  = []
	
	override func viewWillAppear(animated: Bool)
	{
		super.viewWillAppear(animated)
		self.title = diningTitle
		let api = AHAPIReference()
		let data = api.getJSON("organizations/\(orgID)/dinings/\(diningID)/menus")
		let dataString = NSString(data: data, encoding: UInt())
		if dataString!.length > 2
		{
			menusJSON = (try! NSJSONSerialization.JSONObjectWithData(data, options: [])) as! NSMutableArray
			self.tableView.separatorColor = UIColor.whiteColor()
			self.tableView.sectionHeaderHeight = 60
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.tableView.reloadData()
			})
		}
	}
	
	override func  numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return menusJSON.count
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		let menuSection : NSDictionary = menusJSON[section] as! NSDictionary
		let items : String = menuSection["items"] as! String
		let itemArray = items.componentsSeparatedByString(",")
		return Int(ceil(Double(itemArray.count) / 2))
	}
	
	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
	{
		let menuSection : NSDictionary = menusJSON[section] as! NSDictionary
		let title = menuSection["section_title"] as! String
		return title
	}
	
	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
	{
		let sectionCell = tableView.dequeueReusableCellWithIdentifier("sectionCell") as! CafeSectionCell
		sectionCell.sectionTitle.text = menusJSON[section]["section_title"] as? String
		return sectionCell
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier("dataCell") as! CafeDataCell
		var items : String = menusJSON[indexPath.section]["items"] as! String
		items = items.stringByReplacingOccurrencesOfString("\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
		items = items.stringByReplacingOccurrencesOfString("\r", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
//		items = items.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
		var itemArray = items.componentsSeparatedByString(",")
		if indexPath.row > 0
		{
			cell.leftCell.text = itemArray[indexPath.row * 2]
			if (indexPath.row * 2 + 1) < itemArray.count
			{
				cell.rightCell.text = itemArray[indexPath.row * 2 + 1]
			}
			else
			{
				cell.rightCell.text = ""
			}
		}
		else
		{
			cell.leftCell.text = itemArray[indexPath.row]
			if itemArray.count > 1
			{
				cell.rightCell.text = itemArray[indexPath.row + 1]
			}
			else
			{
				cell.rightCell.text = ""
			}
		}
		return cell
	}
}
