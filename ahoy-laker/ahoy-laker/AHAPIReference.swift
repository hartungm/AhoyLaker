//
//  AHAPIReference.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 5/28/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import Foundation

class AHAPIReference
{
	let baseURL : String = "https://ahoylaker.herokuapp.com/api/"
	func getJSON(urlToRequest: String) -> NSData
	{
		let fullURL : String = "\(baseURL)\(urlToRequest)"
		return NSData(contentsOfURL: NSURL(string: fullURL)!)!
	}
	
	func parseJSON(inputData: NSData) -> NSDictionary
	{
		let dictionary: NSDictionary? = NSDictionary()
		return dictionary!
	}
}