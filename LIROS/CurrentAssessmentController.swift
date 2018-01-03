//
//  CurrentAssessmentController.swift
//  LIROS
//
//  Created by Fool on 1/2/18.
//  Copyright © 2018 Fulgent Wake. All rights reserved.
//

import Cocoa

class CurrentAssessmentController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
	
	@IBOutlet weak var currentAssessmentTableView: NSTableView!
	
	var assessmentString = String()
	var assessmentArray = [String]()
	var chosenAssessments = [String]()
	
	weak var assessmentReloadDelegate: assessmentTableDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//assessmentString = cleanArray()
		assessmentArray = getArrayFrom(assessmentString)
	}
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		print("\n\n\nArray Count = \(assessmentArray.count)/n/n/n")
		return assessmentArray.count
	}
	
	func getArrayFrom(_ assessmentString:String) -> [String] {
		var returnArray = assessmentString.components(separatedBy: "\n").filter { $0 != "" && $0 != "  "}
		returnArray = returnArray.map { $0.replacingOccurrences(of: "- ", with: "") }
		
		return returnArray
	}
	
	//Set up the tableview with the data from the assmentArray array
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
		print("/n/n/nvw successfully created/n/n/n")
		vw.textField?.stringValue = assessmentArray[row]
		
		return vw
	}
	
	@IBAction func getDataFromSelectedRow(_ sender:Any) {
		let currentRow = currentAssessmentTableView.row(for: sender as! NSView)
		//print(currentRow)
		if (sender as! NSButton).state == .on {
			chosenAssessments.append(assessmentArray[currentRow])
		} else if (sender as! NSButton).state == .off {
			chosenAssessments = chosenAssessments.filter { $0 != assessmentArray[currentRow] }
		}
		//print(chosenMeds)
		
	}
	
	func cleanArray() -> String {
		var results = assessmentString
//		for item in unwantedBits {
//			results = results.replacingOccurrences(of: item, with: "")
//		}
		return results
	}
	
	
	@IBAction func addAssments(_ sender: Any) {
//		let firstVC = presenting as! ViewController
//		firstVC.medList += chosenMeds
//		medReloadDelegate?.currentMedsWillBeDismissed(sender: self)
//		self.dismiss(self)
	}
	
	
}
