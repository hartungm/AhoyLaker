//
//  OffersDetailTableViewController.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 6/21/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit

class OffersDetailTableViewController: UITableViewController
{
	
	var orgID = 0
	var orgTitle = ""
	var offersJSON = []
	
	override func viewWillAppear(animated: Bool)
	{
		super.viewWillAppear(animated)
		self.title = orgTitle
		self.tableView.rowHeight = 150
		let api = AHAPIReference()
		let data = api.getJSON("organizations/\(orgID)/offers")
		do
		{
			offersJSON = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSMutableArray
			print(offersJSON)
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.tableView.reloadData()
			})
		}
		catch
		{
			print("JSON Error")
		}
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return offersJSON.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> OffersDetailTableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! OffersDetailTableViewCell
		cell.titleLabel.text = offersJSON[indexPath.row]["name"] as? String
		cell.promoDetailLabel.text = offersJSON[indexPath.row]["promo_details"] as? String
		cell.descriptionLabel.text = offersJSON[indexPath.row]["description"] as? String
		cell.offerID = offersJSON[indexPath.row]["id"] as! Int
		cell.orgID = offersJSON[indexPath.row]["organization_id"] as! Int
		cell.couponCode = offersJSON[indexPath.row]["coupon_code"] as! String
//		cell.getCouponCodeButton.addTarget(self, action: Selector(performSegueWithIdentifier("QRSegue", sender: cell)), forControlEvents: UIControlEvents.TouchUpInside)
		return cell
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		let cellSelected = sender as! OffersDetailTableViewCell
		let newController = segue.destinationViewController as! OffersQRController
		newController.couponCode = cellSelected.couponCode
		newController.titleTop = cellSelected.titleLabel.text!
		newController.descriptionText = cellSelected.descriptionLabel.text!
	}
}
