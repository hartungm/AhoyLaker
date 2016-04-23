//
//  CafeTableViewController.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 6/6/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit

class CafeTableViewController: UITableViewController
{
	var json : NSMutableArray = []
	
	override func viewWillAppear(animated: Bool)
	{
		super.viewWillAppear(true)
		self.navigationController!.navigationBar.barTintColor = UIColor(red: (117/255), green: (203/255), blue: (203/255), alpha: 1)
		self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
		self.tabBarController?.title = "Cafeterias"
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.tableView.rowHeight = 150
		let api = AHAPIReference()
		let data = api.getJSON("organizations")
		do {
			let orgs = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSMutableArray
			for org in orgs
			{
				let type = org["org_type"] as? Int
				if type < 3 || type > 3
				{
					let id = org["id"] as! Int
					let data = api.getJSON("organizations/\(id)/dinings")
					if data.length > 2
					{
						let newCafes = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSMutableArray
						for cafe in newCafes
						{
							json.addObject(cafe)
						}
					}
				}
			}
		}
		catch
		{
			print("JSON error")
		}
		UIApplication.sharedApplication().networkActivityIndicatorVisible = false
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return json.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CafeTableViewCell
	{
		let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! CafeTableViewCell
		let index = indexPath.row
		cell.cafeTitle.text = json[index]["name"] as? String
		cell.cafeLocation.text = json[index]["location"] as? String
		cell.cafeID = json[index]["id"] as! Int
		cell.orgID = json[index]["organization_id"] as! Int
		cell.cafeHours.text = getHoursBasedOnDay(index, orgID: cell.orgID, cafeID: cell.cafeID)
		return cell
	}
	
	func getHoursBasedOnDay(index: Int, orgID: Int, cafeID: Int) -> String
	{
		// Query Backend for hours
		let queryString = "organizations/\(orgID)/dinings/\(cafeID)/hours"
		let api = AHAPIReference()
		let data = api.getJSON(queryString)
		var hoursForDay = ""
		do
		{
			let hours = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSMutableArray
			var hoursOfWeek = [String : String]()
			for hour in hours
			{
				let day = hour["title"] as! String
				let data = hour["data"] as! String
				hoursOfWeek[day] = data
			}
			// Finding Date
			let today = NSDate()
//			var dateFormatter = NSDateFormatter()
			let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
			let components = calendar?.components(.NSWeekdayCalendarUnit, fromDate: today)
			let weekDay = components?.weekday
			
			// After Weekday found, check for the correct hours
			if weekDay == 1
			{
				hoursForDay = hoursOfWeek["Sunday"]!
			}
			else if weekDay == 2
			{
				hoursForDay = hoursOfWeek["Monday"]!
			}
			else if weekDay == 3
			{
				hoursForDay = hoursOfWeek["Tuesday"]!
			}
			else if weekDay == 4
			{
				hoursForDay = hoursOfWeek["Wednesday"]!
			}
			else if weekDay == 5
			{
				hoursForDay = hoursOfWeek["Thursday"]!
			}
			else if weekDay == 6
			{
				hoursForDay = hoursOfWeek["Friday"]!
			}
			else if weekDay == 7
			{
				hoursForDay = hoursOfWeek["Saturday"]!
			}
			else
			{
				return "Closed"
			}
		}
		catch
		{
			print("JSON Error")
		}
		return hoursForDay
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
		let cellSelected = sender as! CafeTableViewCell
		let newController = segue.destinationViewController as! MenuTableViewController
		newController.diningID = cellSelected.cafeID
		newController.orgID = cellSelected.orgID
		newController.diningTitle = cellSelected.cafeTitle.text!
	}
}
