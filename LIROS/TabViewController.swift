//
//  TabViewController.swift
//  LIROS
//
//  Created by Fool on 11/22/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class TabViewController: NSTabViewController {
	@IBOutlet weak var MainTabView: NSTabView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
		//makeTabInvisible(self)
    }
	
	@IBAction func makeTabInvisible(_ sender: Any) {
		let doctorTab = MainTabView.indexOfTabViewItem(withIdentifier: "Doctor")
		print("\n\n\n\n\(doctorTab)\n\n\n\n")
		let tabArray = MainTabView.tabViewItems
		print("\n\n\n\nThe tab is: \(tabArray[0])\n\n\n\n")
	}
    
}
