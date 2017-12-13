//
//  DoctorViewController.swift
//  LIROS
//
//  Created by Fool on 10/20/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class DoctorViewController: NSViewController {

	@IBOutlet var doctorTabView: NSView!
	@IBOutlet weak var dataReviewView: NSBox!
	@IBOutlet weak var labView: NSBox!
	@IBOutlet weak var proceduresView: NSBox!
	@IBOutlet weak var educationView: NSBox!
	@IBOutlet weak var injectionsView: NSBox!
	@IBOutlet weak var commonMedsPopup: NSPopUpButton!
    @IBOutlet weak var medicationView: NSTextField!
    @IBOutlet weak var arthPopup: NSPopUpButton!
    @IBOutlet weak var synvPopup: NSPopUpButton!
    
	func getDataFromView(_ view:NSView) -> [(Int, String?)] {
		let tagList = getButtonsIn(view: view)
		return tagList.sorted(by: {$0.0 < $1.0})
	}
		
	func getButtonsIn(view: NSView) -> [(Int, String?)]{
		var results = [(Int, String?)]()
		for item in view.subviews {
			//print(item.tag)
            if let isButton = item as? NSButton {
			//if item is NSButton {
				if isButton.state == .on {
                    switch isButton {
                    case is NSPopUpButton:
                        if !(isButton as! NSPopUpButton).titleOfSelectedItem!.isEmpty {
                            results.append((isButton.tag, (isButton as! NSPopUpButton).titleOfSelectedItem))
                        }
                    default:
						results.append((item.tag, nil))
					}
				}
				//If we don't check tags here we end up with an entry for the NSBox and it's title
			} else if item is NSTextField && item.tag > 0 {
				if (item as! NSTextField).stringValue != "" {
					results.append((item.tag, (item as! NSTextField).stringValue))
				}
			} else if item is NSView {
				results += getButtonsIn(view: item)
			}
		}
		return results
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		clearDrTab(self)
    }
    
    @IBAction func addMed(_ sender: Any) {
        if !commonMedsPopup.titleOfSelectedItem!.isEmpty {
            let currentMeds = medicationView.stringValue
            medicationView.stringValue = commonMedsPopup.titleOfSelectedItem! + "\n" + currentMeds
        }
    }
    
    @IBAction func clearDrTab(_ sender: Any) {
		doctorTabView.clearControllers()
        commonMedsPopup.clearPopUpButton(menuItems: commonMedsList)
        arthPopup.clearPopUpButton(menuItems: jointList)
        synvPopup.clearPopUpButton(menuItems: kneeList)
	}
	
	@IBAction func processDrTab(_ sender: Any) {
		let dataReviewResults = DataReview().processSectionData(getDataFromView(dataReviewView))
		let labViewResults = Lab().processSectionData(getDataFromView(labView))
		let proceduresResults = Procedures().processProceduresUsing(getDataFromView(proceduresView))		
		let educationResults = Education().processSectionData(getDataFromView(educationView))
		let injectionResults = Injections().processSectionData(getDataFromView(injectionsView))
		
		var resultsArray = [dataReviewResults, labViewResults, proceduresResults, educationResults, injectionResults]
        
        if !medicationView.stringValue.isEmpty {
            resultsArray.append("Medications:\n\(medicationView.stringValue)")
        }
		let filteredResultsArray = resultsArray.filter{!$0.isEmpty}
		let results = filteredResultsArray.joined(separator: "\n")
        print(results)
        //Clear the system clipboard
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        //Set the system clipboard to the final text
        pasteBoard.setString(results, forType: NSPasteboard.PasteboardType.string)
	}
}
