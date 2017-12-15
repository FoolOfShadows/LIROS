//
//  DMViewController.swift
//  LIROS
//
//  Created by Fool on 12/5/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class DMViewController: NSViewController {
	
	@IBOutlet var dmTabView: NSView!
	@IBOutlet weak var complianceBox: NSBox!
	@IBOutlet weak var highBSBox: NSBox!
	@IBOutlet weak var lowBSBox: NSBox!
	@IBOutlet weak var labsBox: NSBox!
	@IBOutlet weak var planBox: NSBox!
	
	@IBOutlet weak var compliancePopup: NSPopUpButton!
	@IBOutlet weak var fbsCombo: NSComboBox!
	
	
	@IBOutlet weak var equipmentDifficultyCheckbox: NSButton!
	@IBOutlet weak var glucometerIssuesPopup: NSPopUpButton!
	
	@IBOutlet weak var vibrationSensePopup: NSPopUpButton!
	@IBOutlet weak var monofilamentCheckbox: NSButton!
	
	@IBOutlet weak var uMalbPopup: NSPopUpButton!
	
	@IBOutlet weak var fbsPlanCombo: NSComboBox!
	
	let nc = NotificationCenter.default
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		clearDiabetesTab()
    }
	

	
	
	@IBAction func clearDMTab(_ sender: Any) {
		clearDiabetesTab()
	}
	
	@IBAction func processDMTab(_ sender: Any) {
		let complianceResults = processCompliance(getButtonsIn(view: complianceBox))
		let lowBSResults = processBSSectionData(getStringsForButtonsIn(view: lowBSBox), forType: "low")
		let highBSResults = processBSSectionData(getStringsForButtonsIn(view: highBSBox), forType: "high")
		let equipmentResults = processEquipmentIssues(difficulty: equipmentDifficultyCheckbox.state.rawValue, glucometer: glucometerIssuesPopup.titleOfSelectedItem!)
		let vibrationResults = processVibrationData(vibration: vibrationSensePopup.titleOfSelectedItem!, monofilament: monofilamentCheckbox.state.rawValue)
		let labResults = processLabsUsing(getButtonsIn(view: labsBox))
		let planResults = processPlanUsing(getButtonsIn(view: planBox))
		
		let allResults = [complianceResults, lowBSResults, highBSResults, equipmentResults, vibrationResults, labResults, planResults]
		
		let filteredResults = allResults.filter {!$0.isEmpty}
		
		NSPasteboard.general.clearContents()
		NSPasteboard.general.setString(filteredResults.joined(separator: "\n"), forType: .string)
		
		print(filteredResults.joined(separator: "\n"))
	}
	
	@IBAction func processDMAndContinue(_ sender: Any) {
		processDMTab(self)
		TrackingTabs.newTab = 3
		nc.post(name: NSNotification.Name("SwitchTabs"), object: nil)
		processAndContinue()
	}
	
	func clearDiabetesTab() {
		dmTabView.clearControllers()
		compliancePopup.clearPopUpButton(menuItems: complianceList)
		fbsCombo.clearComboBox(menuItems: checkingFBSList)
		glucometerIssuesPopup.clearPopUpButton(menuItems: glucometerIssuesList)
		vibrationSensePopup.clearPopUpButton(menuItems: vibrationSenseList)
		uMalbPopup.clearPopUpButton(menuItems: umalbList)
		fbsPlanCombo.clearComboBox(menuItems: checkingFBSList)
	}
}
