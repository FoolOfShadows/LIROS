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
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
	@IBAction func clearWWETab(_ sender: Any) {
		wweTabView.clearControllers()
	}
	
	
	@IBAction func processWWETab(_ sender: Any) {
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
		return results
	}
	
	
}
