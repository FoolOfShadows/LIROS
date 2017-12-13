//
//  PrintView.swift
//  LIROS
//
//  Created by Fool on 11/1/17.
//  Copyright © 2017 Fulgent Wake. All rights reserved.
//

import Cocoa

class PrintView: NSView {
	
	override func knowsPageRange(_ range: NSRangePointer) -> Bool {
		
		return true
	}
	
	override func rectForPage(_ page: Int) -> NSRect {
		self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20))
		self.layoutSubtreeIfNeeded()
		return self.bounds
	}

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
