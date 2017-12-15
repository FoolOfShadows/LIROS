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

    
}


struct TrackingTabs {
	static var newTab = 0
}
