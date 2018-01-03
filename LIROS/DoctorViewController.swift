//
//  DoctorViewController.swift
//  LIROS
//
//  Created by Fool on 10/20/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

protocol assessmentTableDelegate: class {
	func currentAssessmentWillBeDismissed(sender: CurrentAssessmentController)
}

class DoctorViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate, assessmentTableDelegate {

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
	@IBOutlet weak var assessmentTableView: NSTableView!
	
	var assessmentString = String()
	var assessmentList = [String]()
	
    let nc = NotificationCenter.default
    
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
            } else {
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
	
	//MARK: Table Handling Functions
	func numberOfRows(in tableView: NSTableView) -> Int {
		return assessmentList.count
	}
	
	//Set up the tableview with the data from the medList array
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
		vw.textField?.stringValue = assessmentList[row]
		
		return vw
	}
	
	@IBAction func getMedsFromFile(_ sender: NSButton) {
		let panel = NSOpenPanel()
		panel.canChooseDirectories = true
		panel.canChooseFiles = true
		panel.allowedFileTypes = ["txt"]
		
		panel.beginSheetModal(for: self.view.window!, completionHandler: {(returnCode) -> Void in
			if returnCode == NSApplication.ModalResponse.OK {
				let message = panel.url?.path
				self.assessmentString = self.processAssessmentFromNoteAt(message)
				self.performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "showCurrentAssessment"), sender: nil)
			}
		})
		
		
	}
	
	func processAssessmentFromNoteAt(_ url: String?) -> String {
		var fullText = String()
		do {
			fullText = try String(contentsOfFile: url!, encoding: String.Encoding.utf8)
		} catch {
			return ""
		}
		
		let medications = fullText.findRegexMatchBetween("Problems:", and: "S:")?.removeWhiteSpace() ?? ""
		
		return medications
	}
	
	override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
		if segue.identifier!.rawValue == "showCurrentAssessment" {
			if let toViewController = segue.destinationController as? CurrentAssessmentController {
				//For the delegate to work, it needs to be assigned here
				//rather than in view did load.  Because it's a modal window?
				toViewController.assessmentReloadDelegate = self
				toViewController.assessmentString = assessmentString
			}
		}
	}
	
	//When the modal window dismisses, it needs to tell the main view to update
	//the script table with the data it passes back using delegation
	func currentAssessmentWillBeDismissed(sender: CurrentAssessmentController) {
		print("Reloading table")
		self.assessmentTableView.reloadData()
	}
}
