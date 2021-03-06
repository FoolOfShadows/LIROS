//
//  WWEViewController.swift
//  LIROS
//
//  Created by Fool on 12/13/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class WWEViewController: NSViewController {

	@IBOutlet var wweTabView: NSView!
	@IBOutlet weak var firstBox: NSBox!
	@IBOutlet weak var fxBox: NSBox!
	@IBOutlet weak var thirdBox: NSBox!
	
	@IBOutlet weak var otherCancerView: NSTextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        setUpMenuItemsForButtonsIn(wweTabView)
    }
    
	@IBAction func clearWWETab(_ sender: Any) {
		wweTabView.clearControllers()
		setUpMenuItemsForButtonsIn(wweTabView)
		WellWomanExam.fxOther = String()
	}
	
	
	@IBAction func processWWETab(_ sender: Any) {
		if !otherCancerView.stringValue.isEmpty {
			WellWomanExam.fxOther = " (\(otherCancerView.stringValue))"
		}
		
		var finalResults = [String]()
		finalResults.append(WellWomanExam().processWWEQuestionsFrom(getButtonsIn(view: firstBox)))
		finalResults.append(WellWomanExam().processFxMatricesData(getMatrixInfoFrom(fxBox)))
		finalResults.append(WellWomanExam().processWWEQuestionsFrom(getButtonsIn(view: thirdBox)))
		
		NSPasteboard.general.clearContents()
		NSPasteboard.general.setString(finalResults.joined(separator: "\n"), forType: .string)
		print(finalResults.joined(separator: "\n"))
	}
	
	func getMatrixInfoFrom(_ view: NSView) -> [(matrix:Int, selections:[Int])] {
		var results = [(matrix:Int, selections:[Int])]()
		let matrices = getMatricesIn(view: view)
		for matrix in matrices {
			let selected = getActiveCellsFromMatrix(matrix)
			if !selected.isEmpty {
				results.append((matrix:matrix.tag, selections:selected))
			}
		}
		//print("getMatrixInfoFrom: \(results)")
		return results.sorted(by: {$0.matrix < $1.matrix})
	}
	
	func setUpMenuItemsForButtonsIn(_ view: NSView) {
		for item in view.subviews {
			if item is NSPopUpButton {
				(item as! NSPopUpButton).clearPopUpButton(menuItems: WellWomanExam().getListItemsForID(item.tag))
			} else if item is NSComboBox {
				(item as! NSComboBox).clearComboBox(menuItems: WellWomanExam().getListItemsForID(item.tag))
			} else if item is NSView {
				setUpMenuItemsForButtonsIn(item)
			}
		}
	}
	
}
