//
//  ServicesWebViewController.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 6/6/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit

class ServicesWebViewController: UIViewController, UIWebViewDelegate
{

	@IBOutlet weak var webView: UIWebView!
	var url: String = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.webView.delegate = self
		let urlString = self.url.stringByReplacingOccurrencesOfString(" ", withString: "", options: [], range: nil)
		let url = NSURL(string: urlString)
		let request = NSURLRequest(URL: url!)
		self.webView.loadRequest(request)
		self.webView.scalesPageToFit = true
	}
	
}
