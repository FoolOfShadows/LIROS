//
//  MasterTabViewController.swift
//  LIROS
//
//  Created by Fool on 12/15/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class MasterTabViewController: NSTabViewController {
	@IBOutlet weak var mainTabView: NSTabView!
    override func viewDidLoad() {
        super.viewDidLoad()
		let nc = NotificationCenter.default
		nc.addObserver(self, selector: #selector(switchToTab), name: Notification.Name("SwitchTabs"), object: nil)
        // Do view setup here.
    }
	
	@objc func switchToTab() {
		mainTabView.selectTabViewItem(at: TrackingTabs.newTab)
	}
	
	
	//Make sure to remove the notification center observer to stop possible memory leaks
	deinit {
		NotificationCenter.default.removeObserver(self)
	}

    
}


struct TrackingTabs {
	static var newTab = 0
}


func getSectionDataFrom(_ rawData:String, delimiters:(start:String, stop:String)) -> [String] {
	var returnData = [String]()
	guard let rawData = getPrefDataFrom("\(NSHomeDirectory())/WPCMSharedFiles/WPCM Software Bits/00 CAUTION - Data Files/LIROSPrefFile.txt") else {return [String]()}
	if let sectionData = rawData.findRegexMatchBetween(delimiters.start, and: delimiters.stop) {
		returnData = sectionData.components(separatedBy: "\n")
	}
	
	
	return returnData
}


func getPrefDataFrom(_ filePath:String) -> String? {
	var data = String()
	
	do {
		data = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
	} catch {
		let theAlert = NSAlert()
		theAlert.messageText = "Could not import the cleaning text from file at \(filePath)."
		theAlert.alertStyle = NSAlert.Style.warning
		theAlert.addButton(withTitle: "OK")
		theAlert.runModal()
		return nil
	}
	
	return data
}
