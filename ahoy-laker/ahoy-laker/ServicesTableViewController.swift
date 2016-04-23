//
//  ServicesTableViewController.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 5/31/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ServicesTableViewController: PFQueryTableViewController
{
	var url = ""
	var parentKey = "top"
	
	override func viewWillAppear(animated: Bool)
	{
		super.viewWillAppear(true)
		self.navigationController!.navigationBar.barTintColor = UIColor(red: 0.231, green: 0.565, blue: 0.808, alpha: 1)
		self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
		self.tabBarController?.title = "Services"
		UIApplication.sharedApplication().networkActivityIndicatorVisible = false
	}
	
	override func queryForTable() -> PFQuery
	{
		let query : PFQuery = PFQuery(className: "Services")
		query.whereKey("parentKey", equalTo: self.parentKey)
		query.orderByAscending("name")
		return query
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell?
	{
		let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! ServicesTableViewCell!
		cell.titleLabel!.text = object?.objectForKey("name") as! String?
		cell.type = object?.objectForKey("type") as! String
		if object?.objectForKey("url") != nil
		{
			cell.url = object?.objectForKey("url") as! String
		}
		cell.childKey = object?.objectForKey("key") as! String
		return cell
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: false)
		let cell = tableView.cellForRowAtIndexPath(indexPath) as! ServicesTableViewCell
		if cell.type == "web"
		{
			self.url = cell.url
			self.performSegueWithIdentifier("toWebView", sender: self)
		}
		else
		{
			let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ServicesTableViewController") as! ServicesTableViewController
			controller.parentKey = cell.childKey
			self.navigationController?.pushViewController(controller, animated: true)
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.destinationViewController.isKindOfClass(ServicesWebViewController)
		{
			let webViewController = segue.destinationViewController as! ServicesWebViewController
			webViewController.url = self.url
		}
	}
}
