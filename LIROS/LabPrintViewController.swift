//
//  LabPrintViewController.swift
//  LIROS
//
//  Created by Fool on 11/2/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class LabPrintViewController: NSViewController {

	@IBOutlet var printView: NSTextView!
	var textToPrint = String()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		printView.string = textToPrint
    }
	
	@IBAction func closeWindow(_ sender: Any) {
		//Because I'm using a 'show' segue this seems
		//to be the only way to close the window
		self.view.window?.close()
	}
	
	@IBAction func takePrintLab(_ sender: AnyObject) {
		let myPrintInfo = NSPrintInfo.shared
		
		//Setting the margins to 0 gives the same output as connecting the button
		//to the print action in the interface builder
		//Overall, none of these options seem to help much
		//myPrintInfo.imageablePageBounds.
		myPrintInfo.orientation = .portrait
		myPrintInfo.verticalPagination = .autoPagination
		myPrintInfo.leftMargin = 0
		myPrintInfo.rightMargin = 0
		myPrintInfo.isHorizontallyCentered = true
		myPrintInfo.topMargin = 10
		myPrintInfo.bottomMargin = 0
		//myPrintInfo.scalingFactor = 1
		let myPrintOperation = NSPrintOperation(view: printView, printInfo: myPrintInfo)
		
		myPrintOperation.run()
		
		self.view.window?.close()
	}
}
