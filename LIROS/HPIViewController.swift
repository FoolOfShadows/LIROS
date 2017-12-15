//
//  HPIViewController.swift
//  LIROS
//
//  Created by Fool on 11/7/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class HPIViewController: NSViewController {

	@IBOutlet var hpiView: NSView!
	@IBOutlet weak var complaintsBox: NSBox!
	@IBOutlet weak var uriBox: NSBox!
	@IBOutlet weak var utiBox: NSBox!
	@IBOutlet weak var chestPainBox: NSBox!
	@IBOutlet weak var htnBox: NSBox!
	@IBOutlet weak var cholesterolBox: NSBox!
	
	//@IBOutlet weak var onsetView: NSTextField!
	@IBOutlet weak var phlegmColorCombo: NSComboBox!
	
	let nc = NotificationCenter.default
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		phlegmColorCombo.clearComboBox(menuItems: phlegmColors)
    }
	
	func getTextFieldsFrom(_ view:NSView) -> [NSTextField] {
		var results = [NSTextField]()
		for item in view.subviews {
			if item is NSTextField && (item as! NSTextField).isEditable {
				results.append((item as! NSTextField))
			} else if item is NSView {
				results += getTextFieldsFrom(item)
			}
		}
		return results
	}
	
	func getListOfButtons(_ view:NSView) -> [NSButton] {
		var results = [NSButton]()
		for item in view.subviews {
			if item is NSButton {
				results.append((item as? NSButton)!)
			} else if item is NSView {
				results += getListOfButtons(item)
			}
		}
		//print(results)
		return results
	}
	
	func getTitlesOfActiveButtonsFrom(_ view:NSView) ->(title: String, positives: [String], negatives: [String]) {
		var positiveResults = [String]()
		var negativeResults = [String]()
		var title = String()
		if getTextFieldsFrom(view)[0].stringValue != "" {
			title = getTextFieldsFrom(view)[0].stringValue
		}
		let activeButtons = getListOfButtons(view).filter {$0.state != .off}
		for button in activeButtons {
			if button.state == .mixed {
				positiveResults.append(button.title.lowercased())
			} else if button.state == .on {
				negativeResults.append(button.title.lowercased())
			}
		}
		
		if !phlegmColorCombo.stringValue.isEmpty {
			func addendColorToPhlegmIn(_ result:inout [String]) {
				for (index, item) in result.enumerated() {
					if item == "phlegm" {
						result[index] = "\(phlegmColorCombo.stringValue) colored phlegm"
					}
				}
			}
			addendColorToPhlegmIn(&positiveResults)
			//addendColorToPhlegmIn(&negativeResults)
		}
		
		
		
		
		return (title:title, positives:positiveResults, negatives:negativeResults)
	}
	
	@IBAction func clearHPI(_ sender: Any) {
		hpiView.clearControllers()
		phlegmColorCombo.clearComboBox(menuItems: phlegmColors)
	}
	
	@IBAction func processHPI(_ sender: Any) {
		var resultsArray = [String]()
		//process Complaints box
		resultsArray.append(processHPISection(.symptoms, usingData: getTitlesOfActiveButtonsFrom(complaintsBox)))
		resultsArray.append(processHPISection(.uti, usingData: getTitlesOfActiveButtonsFrom(utiBox)))
		resultsArray.append(processHPISection(.uri, usingData: getTitlesOfActiveButtonsFrom(uriBox)))
		resultsArray.append(processHPISection(.chestpain, usingData: getTitlesOfActiveButtonsFrom(chestPainBox)))
		resultsArray.append(processHPISection(.htn, usingData: getTitlesOfActiveButtonsFrom(htnBox)))
		resultsArray.append(processHPISection(.hichol, usingData: getTitlesOfActiveButtonsFrom(cholesterolBox)))
		
		let finalArray = resultsArray.filter {$0 != ""}
		if !finalArray.isEmpty {
//			if !onsetView.stringValue.isEmpty {
//				finalArray.append("Onset: \(onsetView.stringValue)")
//			}
			print(finalArray.joined(separator: "\n"))
			//Clear the system clipboard
			let pasteBoard = NSPasteboard.general
			pasteBoard.clearContents()
			//Set the system clipboard to the final text
			pasteBoard.setString(finalArray.joined(separator: "\n"), forType: NSPasteboard.PasteboardType.string)
		}
		
	}
	
	@IBAction func processHPIAndContinue(_ sender: Any) {
		processHPI(self)
		TrackingTabs.newTab = 2
		nc.post(name: NSNotification.Name("SwitchTabs"), object: nil)
		processAndContinue()
	}
}
