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
	
	
}
