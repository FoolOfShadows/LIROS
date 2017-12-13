//
//  LabPrintingViewController.swift
//  LIROS
//
//  Created by Fool on 11/1/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class LabSetUpPrintViewController: NSViewController {
	
	@IBOutlet weak var patientNameView: NSTextField!
	@IBOutlet weak var patientDOBView: NSTextField!
	@IBOutlet weak var currentDateView: NSTextField!
	@IBOutlet weak var mcPrimaryMatrix: NSMatrix!
	
	var labPrintVersion = String()
	var labNoteVersion = String()
	var addOnResult = Int()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/YYYY"
		currentDateView.stringValue = dateFormatter.string(from: Date())
    }
	
	
//	@IBAction func printLab(_ sender: Any) {
//		let printInfo = NSPrintInfo.shared
//		let operation: NSPrintOperation = NSPrintOperation(view: myView, printInfo: printInfo)
//		operation.run()
//	}
	
	override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
		if segue.identifier!.rawValue == "showPrintLabs" {
			self.dismiss(self)
			
			var mcPrimary = String()
			if mcPrimaryMatrix.selectedCell()!.tag == 1 {
				mcPrimary = "YES"
			} else if mcPrimaryMatrix.selectedCell()!.tag == 0 {
				mcPrimary = "NO"
			}
			var addOn = String()
			if addOnResult == 1 {
				addOn = "— ADD ON LAB —"
			}
			
			let patientInfo = ("NAME:  \(patientNameView.stringValue)" + "\t\t" + "M/C PRIMARY:  \(mcPrimary)"
				+ "\n"
				+ "\(patientDOBView.stringValue)" + "\n\n"
				+ addOn
				+ "\n\n"
				+ "DATE ORDERED:  \(currentDateView.stringValue)")
			let headerLabels = ("TEST" + "\t" + " - " + "\t" + "DX CODE")
			
			let labOrderOutputText = "\(headerInfo)" + "\n\n"
				+ "\(patientInfo)" + "\n\n"
				+ "\(headerLabels)" + "\n"
				+ "\(labPrintVersion)" + "\n\n\n\n"
				+ "Dawn Whelchel, MD" + "\n\n\n\n"
				+ "\(labNoteVersion)"
			
			if let toViewController = segue.destinationController as? LabPrintViewController {
				toViewController.textToPrint = labOrderOutputText
			}
		}
	}
	
	
    
}
