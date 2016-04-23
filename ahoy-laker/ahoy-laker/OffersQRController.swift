//
//  OffersQRController.swift
//  ahoy-laker
//
//  Created by Michael Hartung on 6/21/15.
//  Copyright (c) 2015 hartung-michael. All rights reserved.
//

import UIKit
import MessageUI

class OffersQRController: UIViewController, MFMailComposeViewControllerDelegate
{
	var couponCode = ""
	var titleTop = ""
	var descriptionText = ""
	var qrcodeImage : CIImage!
	var transformedImage : CIImage!
	var imagePlease : UIImage!
	@IBOutlet weak var QRImageView: UIImageView!
	@IBOutlet weak var couponCodeLabel: UILabel!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Email", style: .Plain, target: self, action: "sendQREmail")
		self.title = titleTop
		self.couponCodeLabel.text = "Coupon Code: \(self.couponCode)"
		let data = self.couponCode.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
		
		let filter = CIFilter(name: "CIQRCodeGenerator")
		
		filter!.setValue(data, forKey: "inputMessage")
		filter!.setValue("Q", forKey: "inputCorrectionLevel")
		
		qrcodeImage = filter!.outputImage
		let scaleX = self.QRImageView.frame.size.width / qrcodeImage.extent.size.width
		let scaleY = self.QRImageView.frame.size.height / qrcodeImage.extent.size.height
		
		transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
		self.imagePlease = UIImage(CIImage: transformedImage)
		self.QRImageView.image = imagePlease
		UIApplication.sharedApplication().networkActivityIndicatorVisible = false
	}
	
	func sendQREmail()
	{
		let mc = MFMailComposeViewController()
		mc.setSubject(self.titleTop)
		mc.mailComposeDelegate = self
		let destinationSize = CGSizeMake(200, 200)
		UIGraphicsBeginImageContext(destinationSize);
		imagePlease.drawInRect(CGRectMake(0, 0, destinationSize.width, destinationSize.height))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		let data = UIImagePNGRepresentation(newImage)
		UIGraphicsEndImageContext()
		let base64StringData = data!.base64EncodedStringWithOptions([])
		mc.setMessageBody("<p>\(self.descriptionText)</p><p>Coupon Code: \(self.couponCode)</p><img src='data:image/png;base64,\(base64StringData)'>", isHTML: true)
		self.presentViewController(mc, animated: true, completion: nil)
	}
	
	func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
		switch result.rawValue {
		case MFMailComposeResultCancelled.rawValue:
			print("Mail cancelled");
		case MFMailComposeResultSaved.rawValue:
			print("Mail saved");
		case MFMailComposeResultSent.rawValue:
			print("Mail sent")
		case MFMailComposeResultFailed.rawValue:
			print("Mail sent failure:")
		default:
			print("Default")
		}
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}
